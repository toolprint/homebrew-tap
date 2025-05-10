require "language/node"

VERSION = "0.0.24"
SHA = "6ab48b4aeffa81b92198b4a9b01152542bf082a28cef84f41770d2696968147f"

class OnegrepCli < Formula
  repo_name = "onegrep/homebrew-tap"
  formula_name = "onegrep-cli"
  
  desc "OneGrep CLI: Discover, search, and manage tools for your agents."
  homepage "https://www.npmjs.com/package/@onegrep/cli"
  license "EULA"

  package_name = "@onegrep/cli"
  version VERSION
  url "https://registry.npmjs.org/#{package_name}/-/cli-#{version}.tgz"
  sha256 SHA
  binary_name = "onegrep-cli"

  livecheck do
    url "https://registry.npmjs.org/#{package_name}/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on "node"

  def install
    system "npm", "install", "--production", "--no-audit", "--no-fund", "--no-package-lock", *Language::Node.std_npm_install_args(libexec), "tsx@^4.19.3"
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      onegrep-cli requires a Node installation to function. You can install one with:
        brew install node
    EOS
  end

  test do
    system "#{bin}/#{binary_name}", "-V"
    assert_match version.to_s, shell_output("#{bin}/#{binary_name} -V")
  end
end