.PHONY: style test lint install clean help

# Default formula (customize as needed)
LOCAL_REPO := $(shell pwd)
FORMULA_NAME := onegrep-cli
FORMULA_FILE := ./Formula/$(FORMULA_NAME).rb
LOCAL_FORMULA_PATH := $(LOCAL_REPO)/$(FORMULA_FILE)
REMOTE_TAP := onegrep/tap
LOCAL_TAP := onegrep/tap-local
FORMULA_VERSION := $(shell grep -m1 'VERSION = "' $(FORMULA_FILE) | sed 's/.*VERSION = "\(.*\)".*/\1/')
BINARY_NAME := onegrep-cli

help:
	@echo "Homebrew Formula Maintenance Commands"
	@echo "------------------------------------"
	@echo "make version    - Show formula version"
	@echo "make sha        - Show formula SHA (fetched from NPM registry)"
	@echo "make info       - Show formula info (using local file)"
	@echo "make style      - Check formula style (only local check available)"
	@echo "make lint       - Run style check"
	@echo "make tap        - Tap this repository locally"
	@echo "make install    - Install formula from local tap"
	@echo "make livecheck  - Install from local tap and run livecheck"
	@echo "make test       - Test install and verify version"
	@echo "make clean      - Remove local tap and clear Homebrew caches"

version:
	@echo "Formula version: $(FORMULA_VERSION)"

update:
	./update-version.sh

info:
	brew info --formula $(FORMULA_FILE)

clean:
	@echo "Cleaning up..."
	-brew uninstall $(FORMULA_NAME)
	-brew untap $(LOCAL_TAP)
	-brew untap $(REMOTE_TAP)
	-brew cleanup $(FORMULA_NAME)
	find "$(shell brew --cache)" -name "*onegrep-cli*" -exec rm -rf {} +
	@echo "Homebrew tap removed and caches cleared" 

tap:
	@echo "Tapping local repository..."
	brew tap $(LOCAL_TAP) $(LOCAL_REPO)

tap-info:
	brew tap-info $(LOCAL_TAP)

install: clean tap
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
