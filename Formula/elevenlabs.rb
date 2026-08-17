class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API Documentation"
  homepage "https://github.com/rishabh-fern/elevenlabs-cli-dist-test"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.1/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "4617f22546cc39b11260bdbd3da1d2965729f50b6dd91d4941e179fff87ccae2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.1/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "c80049dcceb18d141bf245deaefd57f06f8d9571708602f030ffed3b26421cd8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.1/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "822f5c853f6834354a177f67e2d5ba4f9d286e3c84ef8eef70bbc1bee182856e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.1/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "576b6399a6b81332541fe143dd1c8d0c12ed04e81a5bf76d5f7a49260a05b25b"
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
