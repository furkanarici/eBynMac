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

.PHONY: build sign notarize staple dmg release clean

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

release: build sign notarize staple dmg sparkle-sign
	@echo "Release complete: $(DIST_DIR)/$(DMG_NAME)"

clean:
	rm -rf .build $(DIST_DIR)
