# OneGrep Homebrew Tap Development

This document contains instructions for developers who maintain this Homebrew tap.

## Development Setup

The repository uses a Makefile to simplify formula maintenance and testing. The testing environment is completely isolated from the production tap to avoid conflicts.

## Local Testing Workflow

1. **Clone the repository:**
   ```bash
   git clone https://github.com/onegrep/homebrew-tap.git
   cd homebrew-tap
   ```

2. **Run linting and style checks:**
   ```bash
   make lint
   ```

3. **Test the formula locally:**
   ```bash
   # Creates a local tap named onegrep/tap-local pointing to your local directory
   make tap
   
   # Installs the formula from your local tap
   make test
   ```

4. **Verify installation:**
   ```bash
   onegrep --version
   ```

5. **Cleanup after testing:**
   ```bash
   # Removes the local tap and cleans up caches
   make clean
   ```

## Understanding the Local Test Mode

- The local testing creates a separate tap called `onegrep/tap-local`
- This isolates testing from the real `onegrep/tap` users would use
- All test installations use your local formula file
- The cleanup process removes this local tap completely

## Makefile Commands

```
make audit      - Run brew audit on formula
make style      - Check formula style
make lint       - Run audit and style checks
make tap        - Tap local repository for testing
make test       - Test formula installation from local tap
make install    - Install formula from local tap
make uninstall  - Uninstall formula
make clean      - Remove local tap and clear Homebrew caches
```

## Formula Structure

The formula (`onegrep-cli.rb`) follows standard Homebrew conventions:

- Class name matches the formula name in CamelCase
- Supports multiple architectures (ARM64, x86_64)
- Uses GitHub releases for hosting binary files
- Includes SHA256 checksums for verification

## Release Process

When releasing a new version:

1. Update the version in `onegrep-cli.rb`
2. Update SHA256 checksums for each platform:
   - Generate with `shasum -a 256 <binary-file>`
   - Update each platform's SHA in the formula
3. Run `make lint` to verify the formula
4. Test installation locally with `make test`
5. Commit and push changes
6. Users can update with `brew update && brew upgrade onegrep-cli`

## Troubleshooting

### Common Issues

- **Formula audit failures**: Run `make audit` to see specific issues
- **Installation problems**: Use `brew install --verbose --formula ./onegrep-cli.rb` for detailed output
- **SHA mismatch**: Verify checksums match the distributed binaries

### Debugging Commands

```bash
# See detailed install information
brew install --debug --verbose --formula ./onegrep-cli.rb

# Clean Homebrew's cache
brew cleanup

# Get formula info
brew info ./onegrep-cli.rb
``` 