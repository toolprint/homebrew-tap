require "language/node"

VERSION = "0.0.31"
SHA = "8e0427a9e30f62b28eade2d2678061c087e8a3a1cceb2612d9ac84ca062c5104"
SHORT_BIN = "tp-cli"
LONG_BIN = "toolprint"

class TpCli < Formula
  repo_name = "toolprint/homebrew-tap"
  formula_name = "tp-cli"
  
  desc "Toolprint CLI: Discover, search, and manage tools for your agents."
  homepage "https://www.npmjs.com/package/@onegrep/cli"
  license "EULA"

  package_name = "@onegrep/cli"
  version VERSION
  url "https://registry.npmjs.org/#{package_name}/-/cli-#{version}.tgz"
  sha256 SHA
  binary_name = "cli"

  livecheck do
    url "https://registry.npmjs.org/#{package_name}/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on "node"

  def install
    system "npm", "install", "--production", "--no-audit", "--no-fund", "--no-package-lock", *Language::Node.std_npm_install_args(libexec), "tsx@^4.19.3"

    # Do some nice symlinking to change things to toolprint
    bin.install_symlink Dir["#{libexec}/bin/*"]
    mv "#{bin}/cli", "#{bin}/#{LONG_BIN}"
    # Create symlink from short name to long name
    bin.install_symlink "#{LONG_BIN}" => "#{SHORT_BIN}"
  end

  def pour_bottle_check_unsatisfied
    reason = []
    reason << "Node is not installed. Please install Node.js using Homebrew: brew install node" unless which("node")
    reason
  end

  def caveats
    <<~EOS


      ╭──────────────────────────────╮
      │    Welcome to Toolprint!     │
      ╰──────────────────────────────╯

      🎉 Successfully installed! You can use either command to get started:
        • #{LONG_BIN}  (full name)
        • #{SHORT_BIN} (short alias)

      🚀 Quick start:
        #{LONG_BIN} help

      📚 Learn more at https://www.npmjs.com/package/@onegrep/cli


    EOS
  end

  test do
    system "#{bin}/#{binary_name}", "-V"
    assert_match version.to_s, shell_output("#{bin}/#{binary_name} -V")
  end
end