class Knapper < Formula
  desc "Local hybrid search and MCP retrieval for Obsidian-format vaults"
  homepage "https://github.com/mightytribble/knapper"
  url "https://github.com/mightytribble/knapper/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "f249a47fd723ddb8cce4deee325238afb642071caff8903378dd0100e746993e"
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
