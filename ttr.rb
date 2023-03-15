class Ttr < Formula
  desc "Interactive terminal task runner"
  homepage "https://github.com/bazhenov/ttr"
  license "MIT"
  head "https://github.com/bazhenov/ttr.git", branch: "master"

  on_macos do
    url "https://github.com/bazhenov/ttr/releases/download/0.3.0/ttr-0.3.0-x86_64-apple-darwin.tar.gz"
    sha256 "71c848e67ccac5ef18a95da4462fb004d4dce2cacfc99cd5f06503b7a4ee509d"
  end

  on_linux do
    url "https://github.com/bazhenov/ttr/releases/download/0.3.0/ttr-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9d7d1824954dfea085a206d108500ef84d375315a1042449a13ce8fb45569ca9"
  end

  def install
    bin.install "bin/ttr"
  end
end
