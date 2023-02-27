class Ttr < Formula
  desc "Interactive terminal task runner"
  homepage "https://github.com/bazhenov/ttr"
  url "https://github.com/bazhenov/ttr/releases/download/0.1.0/ttr-0.1.0-x86_64-apple-darwin.tar.gz"
  sha256 "306e5f874942e725421499b2750e95050fb98fd94ef5b92fc00bbf85e458057f"
  license "MIT"
  head "https://github.com/bazhenov/ttr.git", branch: "master"

  def install
    bin.install "bin/ttr"
  end
end
