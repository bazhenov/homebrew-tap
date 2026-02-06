class JcpCli < Formula
  desc "JCP cli"
  homepage "https://github.com/JetBrains/jcp-cli"
  version "0.1.0"

  on_macos do
    url "https://github.com"
    sha256 "123"
  end

  def install
    bin.install "bin/jcp"
  end
end
