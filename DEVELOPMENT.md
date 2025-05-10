# OneGrep Homebrew Tap Development

This document contains instructions for developers who maintain this Homebrew tap.

## Development Setup

The repository uses a Makefile to simplify formula maintenance and testing with an isolated testing environment.

## Quick Start for Testing Updates

When updating the formula version or binaries:

1. **Update the formula file:**
   - Change the version number
   - Update SHA256 checksums for each architecture

2. **Test and verify with a single command:**
   ```bash
   make test
   ```
   
   This will:
   - Clean any previous test installs
   - Create a local tap
   - Install the formula
   - Verify the installed version matches the formula

3. **Commit and push changes once tests pass**

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
   onegrep-cli --help
   ```

## Understanding the Local Test Mode

- Testing uses an isolated tap called `onegrep/tap-local`
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

The formula (`onegrep-cli.rb`) follows standard Homebrew conventions:

- Class name matches the formula name in CamelCase (`OnegrepCli`)
- Supports multiple architectures (ARM64, x86_64 for macOS, x86_64 for Linux)
- Uses NPM to install from the registry
- Includes SHA256 checksums for verification

## Release Process

1. **Update the formula:**
   - Update the version in `Formula/onegrep-cli.rb`
   - Update SHA256 checksums for each architecture:
     ```bash
     curl -sL https://registry.npmjs.org/@onegrep/cli/-/cli-VERSION.tgz | shasum -a 256
     ```

2. **Test and verify:**
   ```bash
   make test
   ```

3. **Commit and push changes**

4. **Users can update with:**
   ```bash
   brew update
   brew upgrade onegrep-cli
   ```

## Troubleshooting

### Common Issues

- **Formula syntax errors**: Run `make lint` to detect basic syntax issues
- **Installation problems**: Use `brew install --verbose --formula ./Formula/onegrep-cli.rb` for detailed output
- **SHA mismatch**: Verify checksums match the distributed binaries
- **Version mismatch**: Ensure the binary version output matches formula version

### Debugging Commands

```bash
# See detailed install information
brew install --debug --verbose --formula ./Formula/onegrep-cli.rb

# Clean Homebrew's cache
brew cleanup

# Get formula info
brew info ./Formula/onegrep-cli.rb
``` 