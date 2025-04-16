class OnegrepCli < Formula
  desc "Command-line tool for OneGrep to discover, search, and manage your agents' tools."
  homepage "https://github.com/onegrep/homebrew-tap"
  version "0.3.0"
  license "Proprietary"
  
  repo_name = "onegrep/homebrew-tap"
  formula_name = "onegrep-cli"
  
  if Hardware::CPU.arm?
    url "https://storage.googleapis.com/onegrep-homebrew-formulae/#{formula_name}-darwin-arm64-#{version}"
    sha256 "8db686045c3832d4bddcaba23a156ae3ffbd4cd53a651b1e9cc5a6dcc7dc37e4"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/onegrep-homebrew-formulae/#{formula_name}-darwin-x64-#{version}"
    sha256 "22d28d83559bceae0f51150b4a57cac75ac5fffaef0dcadaae2c3577fcb49e0b"
  end

  def install
    bin.install Dir["*"].first => "onegrep"
  end
end
