# eBeyanname macOS App — Build, Sign, Notarize, Package
#
# Prerequisites:
#   - Xcode with Developer ID Application + Installer certificates
#   - `create-dmg` installed: brew install create-dmg
#   - Sparkle's `sign_update` tool in PATH
#
# Usage:
#   make build        — Release build
#   make sign         — Sign the .app
#   make notarize     — Submit to Apple notarization
#   make dmg          — Create distributable DMG
#   make release      — Full pipeline: build → sign → notarize → dmg

APP_NAME        = eBeyanname
BUNDLE_ID       = com.furkanarici.ebeyanname
SCHEME          = eBeyanname
BUILD_DIR       = .build/release
APP_PATH        = $(BUILD_DIR)/$(APP_NAME).app
DMG_NAME        = $(APP_NAME)-$(VERSION).dmg
DIST_DIR        = dist

# Set via environment or override: make sign TEAM_ID=XXXXXXXXXX
TEAM_ID        ?= REPLACE_WITH_TEAM_ID
SIGNING_CERT   ?= Developer ID Application: $(TEAM_ID)
NOTARY_PROFILE ?= ebeyanname-notary

VERSION        ?= 1.0.0

.PHONY: dev build sign notarize staple dmg pkg release clean

# Dev: build + assemble .app bundle + ad-hoc sign (no Developer account needed)
dev:
	swift build -c release -Xswiftc -DDEVELOPMENT
	@echo "Assembling .app bundle..."
	rm -rf $(BUILD_DIR)/$(APP_NAME).app
	mkdir -p $(BUILD_DIR)/$(APP_NAME).app/Contents/MacOS
	mkdir -p $(BUILD_DIR)/$(APP_NAME).app/Contents/Resources
	mkdir -p $(BUILD_DIR)/$(APP_NAME).app/Contents/Frameworks
	cp $(BUILD_DIR)/$(APP_NAME) $(BUILD_DIR)/$(APP_NAME).app/Contents/MacOS/
	install_name_tool -add_rpath @executable_path/../Frameworks \
		$(BUILD_DIR)/$(APP_NAME).app/Contents/MacOS/$(APP_NAME)
	cp Sources/$(APP_NAME)/Info.plist $(BUILD_DIR)/$(APP_NAME).app/Contents/
	cp Sources/$(APP_NAME)/Resources/AppIcon.icns $(BUILD_DIR)/$(APP_NAME).app/Contents/Resources/
	printf 'APPL????' > $(BUILD_DIR)/$(APP_NAME).app/Contents/PkgInfo
	@# Copy Sparkle.framework
	cp -R $(BUILD_DIR)/Sparkle.framework $(BUILD_DIR)/$(APP_NAME).app/Contents/Frameworks/
	@# Copy SPM resource bundle if it exists
	@if [ -d "$(BUILD_DIR)/$(APP_NAME)_$(APP_NAME).bundle" ]; then \
		cp -R $(BUILD_DIR)/$(APP_NAME)_$(APP_NAME).bundle $(BUILD_DIR)/$(APP_NAME).app/Contents/Resources/; \
	fi
	@echo "Ad-hoc signing..."
	codesign --sign - --force --deep --entitlements eBeyanname.entitlements $(BUILD_DIR)/$(APP_NAME).app
	@echo "Done: $(BUILD_DIR)/$(APP_NAME).app"
	open $(BUILD_DIR)/$(APP_NAME).app

build:
	swift build -c release --arch arm64 --arch x86_64
	@echo "Build complete: $(BUILD_DIR)/$(APP_NAME)"

sign: build
	codesign \
		--sign "$(SIGNING_CERT)" \
		--entitlements eBeyanname.entitlements \
		--options runtime \
		--timestamp \
		--deep \
		--force \
		"$(APP_PATH)"
	@echo "Signing complete"

notarize: sign
	ditto -c -k --keepParent "$(APP_PATH)" /tmp/$(APP_NAME).zip
	xcrun notarytool submit /tmp/$(APP_NAME).zip \
		--keychain-profile "$(NOTARY_PROFILE)" \
		--wait
	@echo "Notarization submitted"

staple: notarize
	xcrun stapler staple "$(APP_PATH)"
	@echo "Notarization ticket stapled"

dmg: staple
	mkdir -p $(DIST_DIR)
	create-dmg \
		--volname "$(APP_NAME)" \
		--window-pos 200 120 \
		--window-size 600 400 \
		--icon-size 100 \
		--icon "$(APP_NAME).app" 150 185 \
		--hide-extension "$(APP_NAME).app" \
		--app-drop-link 450 185 \
		"$(DIST_DIR)/$(DMG_NAME)" \
		"$(APP_PATH)"
	@echo "DMG created: $(DIST_DIR)/$(DMG_NAME)"

# Generate Sparkle EdDSA signature for the DMG
sparkle-sign: dmg
	sign_update "$(DIST_DIR)/$(DMG_NAME)"

# Unsigned PKG installer (no Developer account needed)
pkg: dev
	mkdir -p $(DIST_DIR)
	@echo "Creating PKG installer..."
	@# Stage the .app into a pkg root
	rm -rf /tmp/$(APP_NAME)-pkgroot
	mkdir -p /tmp/$(APP_NAME)-pkgroot/Applications
	cp -R $(APP_PATH) /tmp/$(APP_NAME)-pkgroot/Applications/
	pkgbuild \
		--root /tmp/$(APP_NAME)-pkgroot \
		--identifier $(BUNDLE_ID) \
		--version $(VERSION) \
		--install-location / \
		$(DIST_DIR)/$(APP_NAME)-$(VERSION)-unsigned.pkg
	rm -rf /tmp/$(APP_NAME)-pkgroot
	@echo "PKG created: $(DIST_DIR)/$(APP_NAME)-$(VERSION)-unsigned.pkg"

release: build sign notarize staple dmg sparkle-sign
	@echo "Release complete: $(DIST_DIR)/$(DMG_NAME)"

clean:
	rm -rf .build $(DIST_DIR)
