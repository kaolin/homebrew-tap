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
  url "https://github.com/kaolin/crew/archive/refs/tags/v0.1.10.tar.gz"
  sha256 "6e79b88b10438524fc670057dfdd6382e030a47caf8d6ee1b6c8192d308487c9"
  license "MIT"
  head "https://github.com/kaolin/crew.git", branch: "main"

  def install
    bin.install "crew"
    bin.install "crew-hub"
    pkgshare.install "hub-protocol.example.md"
    doc.install "docs/reach-your-fleet-from-your-phone.md"
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
    # crew-hub must refuse to start brief-less, and point at the installed example.
    out = shell_output("HUB_PROTOCOL=#{testpath}/nope #{bin}/crew-hub 2>&1", 1)
    assert_match "hub-protocol.example.md", out
  end
end
