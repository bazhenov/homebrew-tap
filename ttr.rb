class Ttr < Formula
  desc "Interactive terminal task runner"
  homepage "https://github.com/bazhenov/ttr"
  license "MIT"
  head "https://github.com/bazhenov/ttr.git", branch: "master"

  on_macos do
    url "https://github.com/bazhenov/ttr/releases/download/0.4.0/ttr-0.4.0-x86_64-apple-darwin.tar.gz"
    sha256 "c7072ae445e7a310a4fe9d3a13d1dd948ec2fae9477f260e2f515446b4a55dfe"
  end

  on_linux do
    url "https://github.com/bazhenov/ttr/releases/download/0.4.0/ttr-0.4.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "32e5a6255647730e5e46cdb042265600e64a61cefa008e6b9dcda84798f697f5"
  end

  def install
    bin.install "bin/ttr"
  end
end
