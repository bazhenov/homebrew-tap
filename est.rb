class Est < Formula
  desc "Fast probabilistic cli utilities for estimating cardinality"
  homepage "https://github.com/bazhenov/fast-estimate"
	url "https://github.com/bazhenov/fast-estimate/archive/v0.1.1.tar.gz"
  sha256 "54a6b42186d470fdb7e43d2d26e3316690a6eb613a48ab22c305ce21674eabb5"

  depends_on "rust" => :build

	bottle do
		root_url "https://github.com/bazhenov/fast-estimate/releases/download/v0.1.1/"
    sha256 "06c66c00b63c1e2bb350ced0f5882b37012d7e068d7991522dbf124d7224c722" => :high_sierra
	end

  def install
		system "cargo", "build", "--release"
		bin.install "target/release/est"
  end
end
