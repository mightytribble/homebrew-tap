class Knapper < Formula
  desc "Local hybrid search and MCP retrieval for Obsidian-format vaults"
  homepage "https://github.com/mightytribble/knapper"
  license "MIT"
  version "0.9.7"

  # Apple Silicon and Linux x86_64 install the released binary,
  # which links nothing outside the system libraries. Every other
  # platform builds from source, so no one loses an install path.
  on_macos do
    on_arm do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.7/knapper-macos-arm64.tar.gz"
      sha256 "c044f97ac356ed35f31a8062742b8b9618b534f45281af0f967cfa278f1c590a"
    end
    on_intel do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.7.tar.gz"
      sha256 "f7c65681e45009e41de0c1dcdb4160debf7c115c62a6cc5bf6bf51c1e5d6e2f3"
      depends_on "cmake" => :build
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.7/knapper-linux-x86_64.tar.gz"
      sha256 "f01f2b5bdf02d4a770bc6c8f79b20d338d7f78a73351b7162e8466dda0c0ef75"
    end
    on_arm do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.7.tar.gz"
      sha256 "f7c65681e45009e41de0c1dcdb4160debf7c115c62a6cc5bf6bf51c1e5d6e2f3"
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
