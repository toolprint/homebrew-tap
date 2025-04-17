class OnegrepCli < Formula
  desc "Command-line tool for OneGrep to discover, search, and manage your agents' tools."
  homepage "https://github.com/onegrep/homebrew-tap"
  version "0.3.1"
  license "Proprietary"
  
  repo_name = "onegrep/homebrew-tap"
  formula_name = "onegrep-cli"
  
  if Hardware::CPU.arm?
    url "https://storage.googleapis.com/onegrep-homebrew-formulae/#{formula_name}-darwin-arm64-#{version}"
    sha256 "65d9c8953188b5d027c4a6f2bac7659d4b246eadf7902ecc00cf82bbbbcffe73"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/onegrep-homebrew-formulae/#{formula_name}-darwin-x64-#{version}"
    sha256 "d262278507893a6739975aa3bc2631e47de8f59da934446656785f646b71513b"
  end

  def install
    bin.install Dir["*"].first => "onegrep"
  end
end
