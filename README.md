# Toolprint Homebrew Tap

Official Homebrew tap for Toolprint tools.

## Available Formulae

- `tp-cli`: The official Toolprint CLI. Use this to discover, search, and manage tools for your agents.

## Installation

```bash
# Install Toolprint CLI
brew install toolprint/tap/tp-cli
```

After installation, you can use either of these commands:
- `toolprint` (full name)
- `tp-cli` (short alias)

## Quick Start

```bash
# View all available commands
toolprint help

# Get the current version
toolprint --version
```

## Updating

When new versions are available, update with:

```bash
brew update
brew upgrade tp-cli
```

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for details.

The Toolprint CLI binary itself is licensed under a separate proprietary license.

---

*For tap maintainers: See [DEVELOPMENT.md](DEVELOPMENT.md) for maintenance instructions.* 