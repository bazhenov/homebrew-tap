class ThreadCounters < Formula
  desc "macOS cli reporting thread P/E performance counters on Apple Silicon"
  homepage "https://github.com/bazhenov/thread-counters"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bazhenov/thread-counters/releases/download/v0.1.0/thread-counters-aarch64-apple-darwin.tar.xz"
      sha256 "81ccfccc37aef99219cece196bc52e20e89fe13b9bff28a71d7568a5086f0be6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bazhenov/thread-counters/releases/download/v0.1.0/thread-counters-x86_64-apple-darwin.tar.xz"
      sha256 "9c67d4c05c03d4fcfb8d94bacd050110bfd7a9996dcd98290d3f0bc0166b4045"
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
    bin.install "thread-counters" if OS.mac? && Hardware::CPU.arm?
    bin.install "thread-counters" if OS.mac? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
