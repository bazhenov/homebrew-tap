class Jcp < Formula
  desc "JetBrains Cloud Platform CLI"
  homepage "https://github.com/bazhenov/jcp-cli"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.2.0/jcp-aarch64-apple-darwin.tar.xz"
      sha256 "28a001ba562017130367e5160ec4a9d8d7ea443832e0f15019ee253ff0d85222"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.2.0/jcp-x86_64-apple-darwin.tar.xz"
      sha256 "b116d3e039ac18390019a83c8326fef2c057f939d1b688692fd36bb964e5a6c7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.2.0/jcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7c99ed058e3c82648417dbb52be443392d3c34179ecf434f890fa9027d377b6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.2.0/jcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9cd4ccfb9b69af816dcfd650792f9b99cb904ad2a4f8d4dcd26298dbbf597943"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "jcp" if OS.linux? && Hardware::CPU.arm?
    bin.install "jcp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
