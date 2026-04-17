class Jcp < Formula
  desc "JetBrains Cloud Platform CLI"
  homepage "https://github.com/bazhenov/jcp-cli"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.5.0/jcp-aarch64-apple-darwin.tar.xz"
      sha256 "9a5aabd2ff76675c725a8f08152987747e2c2aa58a8177edf639496ef003a964"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.5.0/jcp-x86_64-apple-darwin.tar.xz"
      sha256 "7a00b1323ddc83b21683ffc9b030be1651b32d10b8165e5b1a8c84726582e6d0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.5.0/jcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "08b438a4cf184439f6e14793bd51145e460aeb9a0c87714e0cc2ac4cff65fd10"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bazhenov/jcp-cli/releases/download/v0.5.0/jcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8876e755c3702fb788dba0661aeda03a20df73cb3669b94477918fde416f3281"
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
