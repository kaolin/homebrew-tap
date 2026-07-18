# Homebrew formula for `crew`.
#
# NOTE: replace `kaolin` below with your actual GitHub username if it differs.
#
# Stable install:  brew install kaolin/tap/crew
# Bleeding edge:    brew install --HEAD kaolin/tap/crew
# New release: bump the tag, url, and sha256 (see the tap README).
class Crew < Formula
  desc "Status console + dispatcher for hand-run Claude Code sessions"
  homepage "https://github.com/kaolin/crew"
  license "MIT"
  url "https://github.com/kaolin/crew/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "83f9aa0a1d5eef5803d164799ef641fb28a59a70211898a24178883e53758392"
  head "https://github.com/kaolin/crew.git", branch: "main"

  def install
    bin.install "crew"
  end

  # Manages crew's snapshot launchd agent: `brew services start crew`.
  service do
    run [opt_bin/"crew", "snapshot"]
    run_type :interval
    interval 300
    log_path var/"log/crew-snapshot.log"
    error_log_path var/"log/crew-snapshot.log"
  end

  test do
    assert_match "status", shell_output("#{bin}/crew --help")
  end
end
