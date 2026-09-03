class Knapper < Formula
  desc "Local hybrid search and MCP retrieval for Obsidian-format vaults"
  homepage "https://github.com/mightytribble/knapper"
  license "MIT"
  version "0.9.5"

  # Apple Silicon and Linux x86_64 install the released binary,
  # which links nothing outside the system libraries. Every other
  # platform builds from source, so no one loses an install path.
  on_macos do
    on_arm do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.5/knapper-macos-arm64.tar.gz"
      sha256 "05205168cd2a4cf35bb9b2c5ff02e3aaa88c9d3b71037fc347f6ac2b3da89344"
    end
    on_intel do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.5.tar.gz"
      sha256 "ec3e0dd657a6122b2e36e9320da07ced442423267bd3e1a9331d2cd61ed1610b"
      depends_on "cmake" => :build
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.5/knapper-linux-x86_64.tar.gz"
      sha256 "69febd63e92d5dcd4e20b71d32c2713c1344bf692fd990da7048d105c87d7fa6"
    end
    on_arm do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.5.tar.gz"
      sha256 "ec3e0dd657a6122b2e36e9320da07ced442423267bd3e1a9331d2cd61ed1610b"
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
