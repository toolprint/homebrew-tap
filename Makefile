.PHONY: style test lint install clean help clean_all tap_all lint_all

# Default formula (customize as needed)
LOCAL_REPO := $(shell pwd)
FORMULA_NAME := tp-cli
FORMULA_FILE := ./Formula/$(FORMULA_NAME).rb
LOCAL_FORMULA_PATH := $(LOCAL_REPO)/$(FORMULA_FILE)
FORMULA_VERSION := $(shell grep -m1 'VERSION = "' $(FORMULA_FILE) | sed 's/.*VERSION = "\(.*\)".*/\1/')
BINARY_NAME := tp-cli

# Tap configuration
REMOTE_TAP := toolprint/tap
LOCAL_TAP := toolprint/tap-local

# Include legacy targets
include legacy.mk

help:
	@echo "Homebrew Formula Maintenance Commands"
	@echo "------------------------------------"
	@echo "Current Formula ($(FORMULA_NAME)):"
	@echo "make version    - Show formula version"
	@echo "make sha        - Show formula SHA (fetched from NPM registry)"
	@echo "make info       - Show formula info (using local file)"
	@echo "make style      - Check formula style"
	@echo "make lint       - Run style check"
	@echo "make tap        - Tap this repository locally"
	@echo "make install    - Install formula from local tap"
	@echo "make livecheck  - Install from local tap and run livecheck"
	@echo "make test       - Test install and verify version"
	@echo "make clean      - Remove local tap and clear Homebrew caches"
	@echo ""
	@echo "Legacy Formula ($(OG_FORMULA_NAME)):"
	@echo "make legacy_version    - Show legacy formula version"
	@echo "make legacy_info       - Show legacy formula info"
	@echo "make legacy_style      - Check legacy formula style"
	@echo "make legacy_lint       - Run legacy style check"
	@echo "make legacy_install    - Install legacy formula"
	@echo "make legacy_test       - Test legacy install"
	@echo ""
	@echo "Combined Commands:"
	@echo "make clean_all  - Clean both current and legacy formulas"
	@echo "make tap_all    - Tap repository for both formulas"
	@echo "make lint_all   - Run lint checks on both formulas"

version:
	@echo "Formula version: $(FORMULA_VERSION)"

update:
	./update-version.sh

info:
	brew info --formula $(FORMULA_FILE)

unlink:
	-brew unlink $(FORMULA_NAME)

clean: unlink
	@echo "Cleaning up $(FORMULA_NAME)..."
	-brew uninstall $(FORMULA_NAME)
	-brew untap $(LOCAL_TAP)
	-brew untap $(REMOTE_TAP)
	-brew cleanup $(FORMULA_NAME)
	find "$(shell brew --cache)" -name "*$(FORMULA_NAME)*" -exec rm -rf {} +
	@echo "Homebrew tap removed and caches cleared for $(FORMULA_NAME)" 

tap:
	@echo "Tapping local repository for $(FORMULA_NAME)..."
	brew tap $(LOCAL_TAP) $(LOCAL_REPO)

tap-info:
	brew tap-info $(LOCAL_TAP)

install: clean unlink tap
	@echo "Installing from local tap..."
	brew install --formula $(LOCAL_FORMULA_PATH)

livecheck: install
	brew livecheck --formula $(FORMULA_FILE)

style:
	@echo "Checking style of $(FORMULA_FILE)..."
	@ruby -c $(FORMULA_FILE)
	@echo "Syntax check passed"

lint: style
	@echo "Linting complete (note: full audit requires formula to be in core tap)"

test: clean install
	@echo "Testing installation..."
	@echo "Expected version: $(FORMULA_VERSION)"
	@echo -n "Installed version: "
	@INSTALLED_VERSION=$$($(BINARY_NAME) --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' || echo "unknown"); \
	echo $$INSTALLED_VERSION; \
	if [ "$$INSTALLED_VERSION" = "$(FORMULA_VERSION)" ]; then \
		echo "✅ Version check passed!"; \
	else \
		echo "❌ Version mismatch!"; \
		exit 1; \
	fi

# Combined targets
clean_all: clean legacy_clean
	@echo "Cleanup completed for both formulas."

tap_all: tap legacy_tap
	@echo "Tapping completed for both formulas."

lint_all: lint legacy_lint
	@echo "All lint checks completed for both formulas."
