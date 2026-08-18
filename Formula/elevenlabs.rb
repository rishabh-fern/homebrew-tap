class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API Documentation"
  homepage "https://github.com/rishabh-fern/elevenlabs-cli-dist-test"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.2/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "e24af870e20abf4c5c413a26521c3898d4ea906025833fc087073c9d2b4e116d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.2/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "4119004934b3dd241bccfeff5972fc9414666d2850f15a99e9acf213ea743c3b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.2/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dae7a73bd17a8d4e3dfbf57ba3d375c718f34bcf2e80933cd22d1af384322760"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rishabh-fern/elevenlabs-cli-dist-test/releases/download/v0.0.2/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "41e0b1178a39474c3347cf083db3044026475a89c0948d475742e465aee40131"
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
