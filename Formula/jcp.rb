class Jcp < Formula
  desc "JetBrains Cloud Platform CLI"
  homepage "https://github.com/bazhenov/jcp-cli"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.1.1/jcp-aarch64-apple-darwin.tar.xz"
      sha256 "c20d8fa5cf84e0e2c888e5e35dd7f9ba075824ef75f21c185b3841a82291be04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.1.1/jcp-x86_64-apple-darwin.tar.xz"
      sha256 "a1fcf1f4d75a3bbf6268ad1e16ca87c1d328a3e3824e9791293f0d49459c5afe"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "jcp" if OS.mac? && Hardware::CPU.arm?
    bin.install "jcp" if OS.mac? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
