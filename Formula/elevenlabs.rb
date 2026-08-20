class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API Documentation"
  homepage "https://github.com/rishabh-fern/elevenlabs-cli-dist-test"
  version "0.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.6/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "617377c9007b2878bb6dfd3945bd69afa5ca9f85f9ce219aff5afeac69ac3c98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.6/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "c698411d35a143bb16fc6a1155c054f9301521283e4b77c3d6ccff53d835ad93"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.6/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "142db339b83266fae65fb0573fad25c4ec1e5662655c51d72160a0c2bca45a25"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.6/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e4aaa2886d5c264b0f512754605789a2bfd4075cf1b6d1f583ccb97c20a299ff"
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
