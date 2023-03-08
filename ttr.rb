class Ttr < Formula
  desc "Interactive terminal task runner"
  homepage "https://github.com/bazhenov/ttr"
  url "https://github.com/bazhenov/ttr/releases/download/0.2.0/ttr-0.2.0-x86_64-apple-darwin.tar.gz"
  sha256 "8a1bf4ff6fe4832243170366109faa95c500087de0e631b12c1dcdfa1062e90a"
  license "MIT"
  head "https://github.com/bazhenov/ttr.git", branch: "master"

  def install
    bin.install "bin/ttr"
  end
end
