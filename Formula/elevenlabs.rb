class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API Documentation"
  homepage "https://github.com/rishabh-fern/elevenlabs-cli-dist-test"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.3/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "d9b06e95f8810b15ee897bf5f4d5e2351f5d7d854be7693c2cf57c16c70dd195"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.3/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "22bb43101206d3679e497f24a19e59e00f52042c0844f03c9318100ba3fc0e0f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.3/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "361e8a59245727aed8a363417a3ec99d89f6fc02bcaceb76d42b984a6dd7a6cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.3/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c7bdee5194eb9f20c11ab27b49e61bcb6b02662280a382ae92a53367d3489869"
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
