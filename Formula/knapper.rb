class Knapper < Formula
  desc "Local hybrid search and MCP retrieval for Obsidian-format vaults"
  homepage "https://github.com/mightytribble/knapper"
  url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "44fa0a8114c1a3ac2f218273aa98c03e30618fef41b2208d3095d591537eb6dc"
  license "MIT"
  head "https://github.com/mightytribble/knapper.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "knapper #{version}", shell_output("#{bin}/knapper --version")
  end
end
