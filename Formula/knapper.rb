class Knapper < Formula
  desc "Local hybrid search and MCP retrieval for Obsidian-format vaults"
  homepage "https://github.com/mightytribble/knapper"
  license "MIT"
  version "0.9.12"

  # Apple Silicon and Linux x86_64 install the released binary,
  # which links nothing outside the system libraries. Every other
  # platform builds from source, so no one loses an install path.
  on_macos do
    on_arm do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.12/knapper-macos-arm64.tar.gz"
      sha256 "9e3e1e6c4c3658aff0c6e62caa9a77e85bb93be7e15c31cb5c5e3c3328612bc7"
    end
    on_intel do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.12.tar.gz"
      sha256 "8c5b775ae321a095951efa22227d956984c85d38ed29f2a46171204dee14e2e3"
      depends_on "cmake" => :build
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.12/knapper-linux-x86_64.tar.gz"
      sha256 "bf7db05ec4ae54036e0e0ad5fb5957be1a51b2377e1a1a26510c5c0120abcd98"
    end
    on_arm do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.12.tar.gz"
      sha256 "8c5b775ae321a095951efa22227d956984c85d38ed29f2a46171204dee14e2e3"
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
