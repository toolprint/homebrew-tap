require "language/node"

VERSION = "0.0.48"
SHA = "66f0681a366b8dc6a099a17aba92484f7642c9617d201a388098b94bd2106892"
# SHORT_BIN = "tp-cli"
LONG_BIN = "toolprint"

class Toolprint < Formula
  repo_name = "toolprint/homebrew-tap"
  formula_name = "toolprint"
  
  desc "Toolprint CLI: Discover, search, and manage tools for your agents."
  homepage "https://www.npmjs.com/package/@toolprint/cli"
  license "EULA"

  package_name = "@toolprint/cli"
  version VERSION
  url "https://registry.npmjs.org/#{package_name}/-/cli-#{version}.tgz"
  sha256 SHA

  livecheck do
    url "https://registry.npmjs.org/#{package_name}/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on "node"

  def install
    system "npm", "install", "--production", "--no-audit", "--no-fund", "--no-package-lock", *Language::Node.std_npm_install_args(libexec), "tsx@^4.19.3"

    # Only symlink the toolprint binary
    bin.install_symlink "#{libexec}/bin/#{LONG_BIN}"
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

      🎉 Successfully installed! You can use this command to get started:
        • #{LONG_BIN}

      🚀 Quick start:
        #{LONG_BIN} help

      📚 Learn more at https://www.npmjs.com/package/@toolprint/cli


    EOS
  end

  test do
    system "#{bin}/#{LONG_BIN}", "-V"
    assert_match version.to_s, shell_output("#{bin}/#{LONG_BIN} -V")
  end
end