class Knapper < Formula
  desc "Local hybrid search and MCP retrieval for Obsidian-format vaults"
  homepage "https://github.com/mightytribble/knapper"
  license "MIT"
  version "0.9.13"

  # Apple Silicon and Linux x86_64 install the released binary,
  # which links nothing outside the system libraries. Every other
  # platform builds from source, so no one loses an install path.
  on_macos do
    on_arm do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.13/knapper-macos-arm64.tar.gz"
      sha256 "681446a17908813c991e1892cb0cb00ed7dcbe01b521008609ca19478edcda8c"
    end
    on_intel do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.13.tar.gz"
      sha256 "6ff2dfe1f1cc1fdb7b54f3de0d93ddab6b566acc8d4374dc82b713a9fb7f3737"
      depends_on "cmake" => :build
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mightytribble/knapper/releases/download/v0.9.13/knapper-linux-x86_64.tar.gz"
      sha256 "1cc6e35cd03a22419ba6baa3ed214391de1dec2fb15a918bb8da73981d4c038d"
    end
    on_arm do
      url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.13.tar.gz"
      sha256 "6ff2dfe1f1cc1fdb7b54f3de0d93ddab6b566acc8d4374dc82b713a9fb7f3737"
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
