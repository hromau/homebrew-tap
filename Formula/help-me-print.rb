class HelpMePrint < Formula
  desc "Manual duplex printing for printers without automatic double-sided support"
  homepage "https://github.com/hromau/help-me-print"
  # The version is scanned from the release tag in the URL.
  url "https://github.com/hromau/help-me-print-apt/releases/download/v0.1.22/help-me-print-macos.tar.gz"
  sha256 "2460795759b208c7a352097edc727caaed755c64c62567ba36981beed02ce383"

  # The source repository is private, so this formula installs the prebuilt
  # application bundle produced by CI instead of compiling from source. The
  # bundle already carries Qt inside it, so there is nothing to depend on.
  depends_on :macos

  def install
    prefix.install "help-me-print.app"
    bin.write_exec_script prefix/"help-me-print.app/Contents/MacOS/help-me-print"
  end

  def caveats
    <<~EOS
      Help Me Print installs as a macOS app bundle under:
        #{opt_prefix}/help-me-print.app

      Launch it from Terminal with:
        help-me-print

      Or open the bundle directly with:
        open #{opt_prefix}/help-me-print.app
    EOS
  end

  test do
    assert_path_exists prefix/"help-me-print.app/Contents/MacOS/help-me-print"
  end
end
