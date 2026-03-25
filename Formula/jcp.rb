class Jcp < Formula
  desc "JetBrains Cloud Platform CLI"
  homepage "https://github.com/bazhenov/jcp-cli"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.4.0/jcp-aarch64-apple-darwin.tar.xz"
      sha256 "129db13d799cd81ec1fa55c1820ee60ecb5be651ac06236162c1507ca45e1075"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.4.0/jcp-x86_64-apple-darwin.tar.xz"
      sha256 "06135a2c57c46b6a63bfd2fdc3f72a542d0bea263c68bdbaec9f059b5cd560c4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.4.0/jcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7bb69228ac0fc4ff9c4efb7c3a0dfd0860ed5b933c93b0b86f48721e23e6b023"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.4.0/jcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9bc82131753bd75a26d83a8a913592d01f8234878c456f2ad5ec32469ea75ce6"
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
