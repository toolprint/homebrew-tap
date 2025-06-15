# Toolprint Homebrew Tap

[![Website](https://img.shields.io/badge/toolprint.ai-black?style=flat&logo=world&logoColor=white)](https://www.toolprint.ai)
[![NPM version](https://img.shields.io/npm/v/@onegrep/cli.svg)](https://www.npmjs.com/package/@onegrep/cli)
[![Tap License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/toolprint/homebrew-tap/blob/main/LICENSE)
[![CLI License](https://img.shields.io/badge/CLI%20License-EULA-lightgrey.svg)](https://www.npmjs.com/package/@onegrep/cli)

> A universal toolkit that empowers AI agents to discover and execute the right tools for any task.

This repository is the official [Homebrew](https://brew.sh/) tap for the **Toolprint CLI**.

## What is Toolprint?

Toolprint provides an AI-native toolkit for dynamic tool use. It allows your AI agents to securely find, connect to, and run the right tools for any job, from simple API calls to complex, multi-step workflows.

- **Discover more:** Visit our website at [toolprint.ai](https://www.toolprint.ai)
- **Build with our SDK:** Check out the [TypeScript SDK](https://github.com/OneGrep/typescript-sdk)

## Installation

Getting started is simple. You can install the formula with a single command:

```bash
brew install toolprint/tap/toolprint
```

Alternatively, you can tap the repository first, then install the formula:

```bash
brew tap toolprint/tap
brew install toolprint
```

## Quick Start

Once installed, you can use the `toolprint` command.

### 1. Join the Sandbox

The easiest way to get started is to join the Toolprint sandbox, which comes pre-loaded with public tools and connected servers.

Run the following command and follow the prompts to create your account:

```bash
toolprint
```

### 2. Explore Commands

After setting up your account, get started by viewing the available commands:

```bash
toolprint help
```

To check your installed version:
```bash
toolprint --version
```

## Updating

To upgrade to the latest version of the Toolprint CLI, run:

```bash
brew update
brew upgrade toolprint
```

## Reporting Issues & Requesting Features

If you encounter a bug or have an idea for a new feature, we'd love to hear from you. Please use our issue templates on GitHub to provide the necessary details.

*   **🐛 Bug Report:** If the formula isn't working as expected, [file a Bug Report](https://github.com/toolprint/homebrew-tap/issues/new?template=bug_report.yml).

*   **✨ Feature Request:** Have an idea to improve the formula or installation process? [Suggest a new feature](https://github.com/toolprint/homebrew-tap/issues/new?template=feature_request.yml).

Before creating a new issue, please check to see if a similar one has already been opened.

## License

The source code for this Homebrew tap is available under the MIT License. See the [LICENSE](LICENSE) file for more details.

The Toolprint CLI binary distributed by this formula is licensed under a separate EULA.

---

*For tap maintainers: See [DEVELOPMENT.md](DEVELOPMENT.md) for maintenance instructions.* 