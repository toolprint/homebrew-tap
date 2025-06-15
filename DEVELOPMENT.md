# ToolPrint Homebrew Tap Development

This document contains instructions for developers who maintain this Homebrew tap.

## Development Setup

The repository uses a Makefile to simplify formula maintenance and testing with an isolated testing environment.

## Quick Start for Testing Updates

When updating the formula to the latest version:

1. **Run the update script:**
   ```bash
   make update
   ```
   This will automatically fetch the latest version and update the formula file.

2. **Test and verify with a single command:**
   ```bash
   make test
   ```
   
   This will:
   - Clean any previous test installs
   - Create a local tap
   - Install the formula
   - Verify the installed version matches the formula

3. **Commit and push changes once tests pass.**

## Complete Testing Workflow

1. **Clone the repository:**
   ```bash
   git clone https://github.com/onegrep/homebrew-tap.git
   cd homebrew-tap
   ```

2. **Run formula style check:**
   ```bash
   make style
   make lint
   ```

3. **Test the complete installation:**
   ```bash
   make test
   ```

4. **For manual verification:**
   ```bash
   # Install without testing
   make install
   
   # Try the CLI
   tp-cli --help
   ```

## Understanding the Local Test Mode

- Testing uses an isolated tap called `toolprint/tap-local`
- The tap is recreated fresh for each test (cleaned first)
- All tests use your local formula file
- Formula version is automatically extracted and verified

## Makefile Commands

```
make style       - Check formula style (basic syntax check)
make lint        - Run style checks
make clean       - Remove local tap and clear Homebrew caches
make tap         - Tap local repository for testing
make install     - Clean, tap and install formula
make version     - Show the current version of the package in the formula
make update      - Update the version of the package in the formula
make test        - Complete test: clean, install and verify version
```

## Formula Structure

The formula (`tp-cli.rb`) follows standard Homebrew conventions:

- Class name matches the formula name in CamelCase (`TpCli`)
- Supports multiple architectures (ARM64, x86_64 for macOS, x86_64 for Linux)
- Uses NPM to install from the registry
- Includes SHA256 checksums for verification

## Release Process

1. **Update the formula to the latest version:**
   ```bash
   make update
   ```

2. **Test and verify the new version:**
   ```bash
   make test
   ```

3. **Commit and push changes to release.**

4. **Users can update with:**
   ```bash
   brew update
   brew upgrade tp-cli
   ```

## Troubleshooting

### Common Issues

- **Formula syntax errors**: Run `make lint` to detect basic syntax issues
- **Installation problems**: Use `brew install --verbose --formula ./Formula/tp-cli.rb` for detailed output
- **SHA mismatch**: Verify checksums match the distributed binaries
- **Version mismatch**: Ensure the binary version output matches formula version

### Debugging Commands

```bash
# See detailed install information
brew install --debug --verbose --formula ./Formula/tp-cli.rb

# Clean Homebrew's cache
brew cleanup

# Get formula info
brew info ./Formula/tp-cli.rb
``` 