class OnegrepCli < Formula
  desc "Command-line tool for OneGrep to discover, search, and manage your agents' tools."
  homepage "https://github.com/onegrep/homebrew-tap"
  version "0.2.0"
  license "Proprietary"
  
  repo_name = "onegrep/homebrew-tap"
  formula_name = "onegrep-cli"
  
  if Hardware::CPU.arm?
    url "https://storage.googleapis.com/onegrep-homebrew-formulae/#{formula_name}-darwin-arm64-#{version}"
    sha256 "f43ff18813c74482f68a07fdbf2bddb37562d1e2fdf1181ea11e68128866e3ea"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/onegrep-homebrew-formulae/#{formula_name}-darwin-x64-#{version}"
    sha256 "59af568b85227c7b6570c978a41a94991cbcd44e1dfcb3a783e09deda091fcd4"
  end

  def install
    bin.install Dir["*"].first => "onegrep"
  end
end
