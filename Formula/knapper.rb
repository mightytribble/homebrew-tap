class Knapper < Formula
  desc "Local hybrid search and MCP retrieval for Obsidian-format vaults"
  homepage "https://github.com/mightytribble/knapper"
  license "MIT"
  version "0.9.10"

  # Apple Silicon and Linux x86_64 install the released binary,
  # which links nothing outside the system libraries. Every other
  # platform builds from source, so no one loses an install path.
  on_macos do
    on_arm do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.10/knapper-macos-arm64.tar.gz"
      sha256 "743661064531bbeac68ae8b0229fe0ec2ee331b598300af6b42112132a08168c"
    end
    on_intel do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.10.tar.gz"
      sha256 "bcfdfaff1c5279c6cd461b9b2b5206ce2ed3de9312b60e7ed4e81e30e4d16ae6"
      depends_on "cmake" => :build
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.10/knapper-linux-x86_64.tar.gz"
      sha256 "e492fe025e64b9054a99eaa732e7f82cb5878005e1b3bdc3b5066eb47128cdc1"
    end
    on_arm do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.10.tar.gz"
      sha256 "bcfdfaff1c5279c6cd461b9b2b5206ce2ed3de9312b60e7ed4e81e30e4d16ae6"
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
