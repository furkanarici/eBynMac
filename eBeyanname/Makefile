# eBeyanname macOS App — Build, Bundle, Package
#
# Usage:
#   make build          — Release build (universal binary)
#   make bundle         — .app bundle oluşturur
#   make pkg-unsigned   — İmzasız PKG (iç test)
#   make dmg-unsigned   — İmzasız DMG (iç test)
#   make release        — Tam pipeline: build → sign → notarize → DMG
#   make release-pkg    — Tam pipeline: build → sign → notarize → PKG
#   make clean          — .build ve dist temizler
#
# Prerequisites:
#   - Xcode command line tools
#   - `create-dmg` for DMG: brew install create-dmg
#   - Developer ID certificates for signing/notarization

APP_NAME        = eBeyanname
BUNDLE_ID       = com.furkanarici.ebeyanname
VERSION        ?= 1.0.0

# SPM build output paths
PRODUCTS_DIR    = .build/apple/Products/Release
BINARY_PATH     = $(PRODUCTS_DIR)/$(APP_NAME)
RESOURCE_BUNDLE = $(PRODUCTS_DIR)/$(APP_NAME)_$(APP_NAME).bundle
SPARKLE_FW      = $(PRODUCTS_DIR)/Sparkle.framework

# App bundle paths
APP_PATH        = $(PRODUCTS_DIR)/$(APP_NAME).app
CONTENTS_DIR    = $(APP_PATH)/Contents
MACOS_DIR       = $(CONTENTS_DIR)/MacOS
RESOURCES_DIR   = $(CONTENTS_DIR)/Resources
FRAMEWORKS_DIR  = $(CONTENTS_DIR)/Frameworks

# Distribution
DMG_NAME        = $(APP_NAME)-$(VERSION).dmg
PKG_NAME        = $(APP_NAME)-$(VERSION).pkg
DIST_DIR        = dist
PKG_ROOT        = /tmp/$(APP_NAME)-pkg-root
INSTALL_DIR     = /Applications
INFO_PLIST      = Sources/eBeyanname/Resources/Info.plist

# Signing (override: make sign TEAM_ID=XXXXXXXXXX)
TEAM_ID        ?= 5337GU8YAD
SIGNING_CERT   ?= Developer ID Application: $(TEAM_ID)
INSTALLER_CERT ?= Developer ID Installer: $(TEAM_ID)
NOTARY_PROFILE ?= ebeyanname-notary

.PHONY: build bundle sign notarize staple dmg dmg-unsigned pkg pkg-unsigned release release-pkg clean

# ─── Build ────────────────────────────────────────────────────────────

build:
	swift build -c release --arch arm64 --arch x86_64
	@echo "Build complete: $(BINARY_PATH)"

# ─── Bundle ───────────────────────────────────────────────────────────

bundle: build
	@echo "Assembling $(APP_NAME).app bundle..."
	rm -rf "$(APP_PATH)"
	mkdir -p "$(MACOS_DIR)" "$(RESOURCES_DIR)" "$(FRAMEWORKS_DIR)"
	# Copy executable
	cp "$(BINARY_PATH)" "$(MACOS_DIR)/$(APP_NAME)"
	chmod +x "$(MACOS_DIR)/$(APP_NAME)"
	# Copy Info.plist
	cp "$(INFO_PLIST)" "$(CONTENTS_DIR)/Info.plist"
	# Copy SPM resource bundles
	@for b in "$(PRODUCTS_DIR)"/*.bundle; do \
		if [ -d "$$b" ]; then \
			echo "  Copying resource bundle: $$(basename $$b)"; \
			cp -R "$$b" "$(RESOURCES_DIR)/"; \
		fi; \
	done
	# Copy Sparkle framework
	@if [ -d "$(SPARKLE_FW)" ]; then \
		echo "  Copying Sparkle.framework"; \
		cp -R "$(SPARKLE_FW)" "$(FRAMEWORKS_DIR)/"; \
	fi
	# Copy app icon (if .icns exists)
	@for icon in Sources/eBeyanname/Resources/*.icns; do \
		if [ -f "$$icon" ]; then \
			echo "  Copying icon: $$(basename $$icon)"; \
			cp "$$icon" "$(RESOURCES_DIR)/"; \
		fi; \
	done
	@echo "Bundle created: $(APP_PATH)"

# ─── Sign ─────────────────────────────────────────────────────────────

sign: bundle
	codesign \
		--sign "$(SIGNING_CERT)" \
		--entitlements eBeyanname.entitlements \
		--options runtime \
		--timestamp \
		--deep \
		--force \
		"$(APP_PATH)"
	@echo "Signing complete"

# ─── Notarize ─────────────────────────────────────────────────────────

notarize: sign
	ditto -c -k --keepParent "$(APP_PATH)" /tmp/$(APP_NAME).zip
	xcrun notarytool submit /tmp/$(APP_NAME).zip \
		--keychain-profile "$(NOTARY_PROFILE)" \
		--wait
	@echo "Notarization submitted"

staple: notarize
	xcrun stapler staple "$(APP_PATH)"
	@echo "Notarization ticket stapled"

# ─── DMG ──────────────────────────────────────────────────────────────

dmg: staple
	mkdir -p "$(DIST_DIR)"
	rm -f "$(DIST_DIR)/$(DMG_NAME)"
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

dmg-unsigned: bundle
	mkdir -p "$(DIST_DIR)"
	rm -f "$(DIST_DIR)/$(DMG_NAME)"
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
	@echo "DMG (unsigned) created: $(DIST_DIR)/$(DMG_NAME)"

# ─── PKG ──────────────────────────────────────────────────────────────

pkg: staple
	mkdir -p "$(DIST_DIR)"
	rm -rf "$(PKG_ROOT)"
	mkdir -p "$(PKG_ROOT)$(INSTALL_DIR)"
	cp -R "$(APP_PATH)" "$(PKG_ROOT)$(INSTALL_DIR)/"
	pkgbuild \
		--root "$(PKG_ROOT)" \
		--identifier "$(BUNDLE_ID)" \
		--version "$(VERSION)" \
		--install-location / \
		/tmp/$(APP_NAME)-component.pkg
	productbuild \
		--sign "$(INSTALLER_CERT)" \
		--package /tmp/$(APP_NAME)-component.pkg \
		"$(DIST_DIR)/$(PKG_NAME)"
	rm -rf "$(PKG_ROOT)" /tmp/$(APP_NAME)-component.pkg
	xcrun notarytool submit "$(DIST_DIR)/$(PKG_NAME)" \
		--keychain-profile "$(NOTARY_PROFILE)" \
		--wait
	xcrun stapler staple "$(DIST_DIR)/$(PKG_NAME)"
	@echo "PKG created: $(DIST_DIR)/$(PKG_NAME)"

pkg-unsigned: bundle
	mkdir -p "$(DIST_DIR)"
	rm -rf "$(PKG_ROOT)"
	mkdir -p "$(PKG_ROOT)$(INSTALL_DIR)"
	cp -R "$(APP_PATH)" "$(PKG_ROOT)$(INSTALL_DIR)/"
	pkgbuild \
		--root "$(PKG_ROOT)" \
		--identifier "$(BUNDLE_ID)" \
		--version "$(VERSION)" \
		--install-location / \
		"$(DIST_DIR)/$(PKG_NAME)"
	rm -rf "$(PKG_ROOT)"
	@echo "PKG (unsigned) created: $(DIST_DIR)/$(PKG_NAME)"

# ─── Sparkle ──────────────────────────────────────────────────────────

sparkle-sign: dmg
	sign_update "$(DIST_DIR)/$(DMG_NAME)"

# ─── Release pipelines ───────────────────────────────────────────────

release: dmg sparkle-sign
	@echo "Release complete: $(DIST_DIR)/$(DMG_NAME)"

release-pkg: pkg
	@echo "Release complete: $(DIST_DIR)/$(PKG_NAME)"

# ─── Clean ────────────────────────────────────────────────────────────

clean:
	rm -rf .build "$(DIST_DIR)"
