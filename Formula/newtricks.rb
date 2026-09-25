# typed: strict
# frozen_string_literal: true

# Formula for the new-tricks/homebrew-tap tap (Formula/newtricks.rb).
#   brew install new-tricks/tap/newtricks
# This is the template: on each release, .github/workflows/release.yml renders it with
# the tag's source tarball `url` and `sha256` (packaging/homebrew/render.sh) and pushes
# it to the tap. Submit to homebrew-core once the project meets its notability
# requirements.
class Newtricks < Formula
  desc "Design-time workbench for agent skills (search, customize, lint, publish)"
  homepage "https://github.com/new-tricks/tricks"
  url "https://github.com/new-tricks/tricks/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "d0af5af29123d4b4d1f21a652f9014b5115824f4bb9e59438f3cb1800c081ed9"
  license "Apache-2.0"
  head "https://github.com/new-tricks/tricks.git", branch: "main"

  depends_on "rust" => :build
  depends_on "git"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/newtricks")
  end

  test do
    assert_match "tricks", shell_output("#{bin}/tricks --version")
    ENV["TRICKS_HOME"] = testpath
    ENV["TRICKS_CONFIG_DIR"] = testpath/"config"
    ENV["TRICKS_DATA_DIR"] = testpath/"data"
    assert_match "no source repos yet", shell_output("#{bin}/tricks --offline status")
  end
end
