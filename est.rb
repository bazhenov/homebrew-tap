# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Est < Formula
  desc "Fast probabilistic cli utilities for estimating cardinality"
  homepage "https://github.com/bazhenov/fast-estimate"
	url "https://github.com/bazhenov/fast-estimate/archive/v0.1.0.tar.gz"
  sha256 "47243e93c9f22604b2db2adb153d183d40eb75271a4891490896f36c28803551"

  depends_on "rust" => :build

  def install
		system "cargo", "build", "--release"
		bin.install "target/release/est"
  end
end
