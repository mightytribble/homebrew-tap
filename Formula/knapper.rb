class Knapper < Formula
  desc "Local hybrid search and MCP retrieval for Obsidian-format vaults"
  homepage "https://github.com/mightytribble/knapper"
  license "MIT"
  version "0.9.11"

  # Apple Silicon and Linux x86_64 install the released binary,
  # which links nothing outside the system libraries. Every other
  # platform builds from source, so no one loses an install path.
  on_macos do
    on_arm do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.11/knapper-macos-arm64.tar.gz"
      sha256 "6ed760237c088bd6a1f91570045b24d3b5f88e946711f0fa7d8ee85e947cfcec"
    end
    on_intel do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.11.tar.gz"
      sha256 "64ef0deff97dd41f76ba54eb899cc9fd480f7ae91f991693da42077a86ae8c1d"
      depends_on "cmake" => :build
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.11/knapper-linux-x86_64.tar.gz"
      sha256 "f567813001c3f74cbf1e8ab0df8adcfcffc822e974b6aec9ef8f78d8a6530b85"
    end
    on_arm do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.11.tar.gz"
      sha256 "64ef0deff97dd41f76ba54eb899cc9fd480f7ae91f991693da42077a86ae8c1d"
      depends_on "cmake" => :build
      depends_on "rust" => :build
    end
  end

  head do
    url "https://github.com/mightytribble/knapper.git", branch: "main"
    depends_on "cmake" => :build
    depends_on "rust" => :build
  end

  def install
    prebuilt = (OS.mac? && Hardware::CPU.arm?) || (OS.linux? && Hardware::CPU.intel?)
    if build.head? || !prebuilt
      system "cargo", "install", *std_cargo_args
    else
      bin.install "knapper"
    end
  end

  test do
    assert_match "knapper #{version}", shell_output("#{bin}/knapper --version")
  end
end
