.PHONY: audit style test lint install uninstall clean help

# Default formula (customize as needed)
LOCAL_REPO := $(shell pwd)
FORMULA_NAME := onegrep-cli
FORMULA_FILE := $(FORMULA_NAME).rb
LOCAL_FORMULA_PATH := $(LOCAL_REPO)/$(FORMULA_FILE)
LOCAL_TAP := onegrep/tap-local

help:
	@echo "Homebrew Formula Maintenance Commands"
	@echo "------------------------------------"
	@echo "make style      - Check formula style (only local check available)"
	@echo "make lint       - Run style check"
	@echo "make tap        - Tap this repository locally"
	@echo "make install    - Install formula from local tap"
	@echo "make uninstall  - Uninstall formula"
	@echo "make clean      - Remove local tap and clear Homebrew caches"

tap:
	@echo "Tapping local repository..."
	brew tap $(LOCAL_TAP) $(LOCAL_REPO)

style:
	@echo "Checking style of $(FORMULA_FILE)..."
	@ruby -c $(FORMULA_FILE)
	@echo "Syntax check passed"

lint: style
	@echo "Linting complete (note: full audit requires formula to be in core tap)"

install: tap
	@echo "Installing from local tap..."
	brew install --formula $(LOCAL_FORMULA_PATH)

test-install: install
	@echo "Testing installation..."
	-onegrep --version
	@echo "Installation test complete"

uninstall:
	@echo "Uninstalling formula..."
	brew uninstall $(FORMULA_NAME)

clean:
	@echo "Cleaning up..."
	-brew untap $(LOCAL_TAP)
	-brew cleanup $(FORMULA_NAME)
	@echo "Homebrew tap removed and caches cleared" 
