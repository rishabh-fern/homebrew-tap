class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API Documentation"
  homepage "https://github.com/rishabh-fern/elevenlabs-cli-dist-test"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.5/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "a0a763242877b70b6ffde18223440815d545e66f1c3a389a8b54f0a444002480"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.5/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "d3cb266d8e6405cb7cdf5c3ec487c1e5ff53a19ed851dc6bb53413725c74e824"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.5/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "44d79059a77a501852bcedb4e869ca79fe01ac1226f9c0921fc5e931b6e52c5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.5/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "661f640b06b269075443630bd5cee801e9707a8e2958c502c7f2fd1575f43397"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "elevenlabs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "elevenlabs"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "elevenlabs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "elevenlabs"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
