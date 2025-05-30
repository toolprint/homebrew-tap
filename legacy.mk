.PHONY: legacy_style legacy_test legacy_lint legacy_install legacy_version legacy_info legacy_livecheck legacy_clean legacy_tap

# Legacy formula variables
OG_FORMULA_NAME := onegrep-cli
OG_FORMULA_FILE := ./Formula/$(OG_FORMULA_NAME).rb
OG_LOCAL_FORMULA_PATH := $(LOCAL_REPO)/$(OG_FORMULA_FILE)
OG_FORMULA_VERSION := $(shell grep -m1 'VERSION = "' $(OG_FORMULA_FILE) | sed 's/.*VERSION = "\(.*\)".*/\1/')
OG_BINARY_NAME := onegrep-cli

# Legacy tap configuration
OG_REMOTE_TAP := onegrep/tap
OG_LOCAL_TAP := onegrep/tap-local

legacy_version:
	@echo "Legacy formula version: $(OG_FORMULA_VERSION)"

legacy_info:
	brew info --formula $(OG_FORMULA_FILE)

legacy_clean:
	@echo "Cleaning up $(OG_FORMULA_NAME)..."
	-brew uninstall $(OG_FORMULA_NAME)
	-brew untap $(OG_LOCAL_TAP)
	-brew untap $(OG_REMOTE_TAP)
	-brew cleanup $(OG_FORMULA_NAME)
	find "$(shell brew --cache)" -name "*$(OG_FORMULA_NAME)*" -exec rm -rf {} +
	@echo "Homebrew tap removed and caches cleared for $(OG_FORMULA_NAME)"

legacy_tap:
	@echo "Tapping local repository for $(OG_FORMULA_NAME)..."
	brew tap $(OG_LOCAL_TAP) $(LOCAL_REPO)

legacy_install: legacy_clean legacy_tap
	@echo "Installing legacy formula from local tap..."
	brew install --formula $(OG_LOCAL_FORMULA_PATH)

legacy_livecheck: legacy_install
	brew livecheck --formula $(OG_FORMULA_FILE)

legacy_style:
	@echo "Checking style of $(OG_FORMULA_FILE)..."
	@ruby -c $(OG_FORMULA_FILE)
	@echo "Syntax check passed"

legacy_lint: legacy_style
	@echo "Legacy linting complete (note: full audit requires formula to be in core tap)"

legacy_test: legacy_clean legacy_install
	@echo "Testing legacy installation..."
	@echo "Expected version: $(OG_FORMULA_VERSION)"
	@echo -n "Installed version: "
	@INSTALLED_VERSION=$$($(OG_BINARY_NAME) --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' || echo "unknown"); \
	echo $$INSTALLED_VERSION; \
	if [ "$$INSTALLED_VERSION" = "$(OG_FORMULA_VERSION)" ]; then \
		echo "✅ Version check passed!"; \
	else \
		echo "❌ Version mismatch!"; \
		exit 1; \
	fi 