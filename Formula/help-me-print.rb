class HelpMePrint < Formula
  desc "Manual duplex printing for printers without automatic double-sided support"
  homepage "https://github.com/hromau/help-me-print"
  url "https://github.com/hromau/help-me-print/archive/refs/tags/v0.1.17.tar.gz"
  sha256 "62fdb0717cfe5caaddb030b69f45bbd64edf1c2009b4998ab3d31c5675731d57"
  version "0.1.17"

  depends_on "cmake" => :build
  depends_on "qt"

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_BUILD_TYPE=Release",
                    "-DCMAKE_PREFIX_PATH=#{Formula["qt"].opt_prefix}",
                    "-DDUPLEXPRINT_BUILD_TESTS=OFF",
                    "-DDUPLEXPRINT_DEPLOY_QT_RUNTIME=OFF",
                    "-DDUPLEXPRINT_REQUIRE_QT_APP=ON",
                    "-DDUPLEXPRINT_VERSION=#{version}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

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
    assert_predicate prefix/"help-me-print.app/Contents/MacOS/help-me-print", :exist?
  end
end
