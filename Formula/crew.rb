# Homebrew formula for `crew`.
#
# NOTE: replace `kaolin` below with your actual GitHub username if it differs.
#
# This starts as a HEAD-only formula so you can install before cutting a release:
#     brew install --HEAD kaolin/tap/crew
#
# Once you tag a release (see the tap README), uncomment `url` + `sha256` and drop
# `--HEAD` — `brew install kaolin/tap/crew` will then work for everyone.
class Crew < Formula
  desc "Status console + dispatcher for hand-run Claude Code sessions"
  homepage "https://github.com/kaolin/crew"
  license "MIT"
  head "https://github.com/kaolin/crew.git", branch: "main"

  # url "https://github.com/kaolin/crew/archive/refs/tags/v0.1.0.tar.gz"
  # sha256 "REPLACE_WITH_SHASUM_OF_THE_TARBALL"

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
