class Crab < Formula
  desc "Web scraping and parsing toolkit"
  homepage "https://github.com/bazhenov/crab"
  url "https://github.com/bazhenov/crab/releases/download/0.1.0/crab-0.1.0-x86_64-apple-darwin.tar.gz"
  sha256 "93fb7bb46dd00fcaf6147f14b63a1e8cc26e268c2e8f77a1b5e6b35053bf942d"
  license "MIT"
  head "https://github.com/bazhenov/crab.git", branch: "master"

  depends_on "python@3.11"

  def install
    bin.install "crab"
  end

  test do
    system "#{bin}/crab", "new", "workspace"
    assert_predicate testpath/"workspace/db.sqlite", :exist?
  end
end
