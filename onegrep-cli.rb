class OnegrepCli < Formula
  desc "Command-line tool for OneGrep to discover, search, and manage your agents' tools."
  homepage "https://github.com/onegrep/homebrew-tap"
  version "0.2.1"
  license "Proprietary"
  
  repo_name = "onegrep/homebrew-tap"
  formula_name = "onegrep-cli"
  
  if Hardware::CPU.arm?
    url "https://storage.googleapis.com/onegrep-homebrew-formulae/#{formula_name}-darwin-arm64-#{version}"
    sha256 "2e51c5e555085564995ff946590f799e3a7b7b3ee7a56332ba17974bb901493f"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/onegrep-homebrew-formulae/#{formula_name}-darwin-x64-#{version}"
    sha256 "5eeffd903c72a249285d8bdc0d674676fde3a290179f28e71b530080ce6809ae"
  end

  def install
    bin.install Dir["*"].first => "onegrep"
  end
end
