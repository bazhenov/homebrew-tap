class Est < Formula
  desc "Fast probabilistic cli utilities for estimating cardinality"
  homepage "https://github.com/bazhenov/fast-estimate"
	url "https://github.com/bazhenov/fast-estimate/archive/v0.2.tar.gz"
  sha256 "249daca903fb9dd16e2812bf171231dece9d23485236a29853c3a071e254a39d"

  depends_on "rust" => :build

	bottle do
    root_url "https://github.com/bazhenov/fast-estimate/releases/download/v0.2"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "f343d385f549f144f4a9eec9c86930f924b9650d21ac2a21fe2ba90048e35c7b" => :mojave
  end

  def install
		system "cargo", "build", "--release"
		bin.install "target/release/est"
  end
end
