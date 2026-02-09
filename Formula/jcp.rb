class Jcp < Formula
  desc "JetBrains Cloud Platform CLI"
  homepage "https://github.com/jetbrains/jcp-cli"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jetbrains/jcp-cli/releases/download/v0.1.0/jcp-aarch64-apple-darwin.tar.xz"
      sha256 "a986b6948fa8e37840d1867181f3a4245a63325d34345df6f1333ea4ac12139e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jetbrains/jcp-cli/releases/download/v0.1.0/jcp-x86_64-apple-darwin.tar.xz"
      sha256 "5363a45ce9ea72404bc5a20b3c190cc53e5c48193bbeeaa37d25e2ff00db59b6"
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
