class Knapper < Formula
  desc "Local hybrid search and MCP retrieval for Obsidian-format vaults"
  homepage "https://github.com/mightytribble/knapper"
  license "MIT"
  version "0.9.8"

  # Apple Silicon and Linux x86_64 install the released binary,
  # which links nothing outside the system libraries. Every other
  # platform builds from source, so no one loses an install path.
  on_macos do
    on_arm do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.8/knapper-macos-arm64.tar.gz"
      sha256 "50a7c6fcfcdb3991dc3d69bca74f50fecce98a7f0062b5f81fc4e7c7e4858083"
    end
    on_intel do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.8.tar.gz"
      sha256 "c94aa2772e13347cdcad4a928694c13e9e2c6752780f33dfcc7a0184b840735a"
      depends_on "cmake" => :build
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.8/knapper-linux-x86_64.tar.gz"
      sha256 "871f6bba012e61d4059ccc74d2650035f6553ad9987e0db382c3d0589c474c1f"
    end
    on_arm do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.8.tar.gz"
      sha256 "c94aa2772e13347cdcad4a928694c13e9e2c6752780f33dfcc7a0184b840735a"
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
