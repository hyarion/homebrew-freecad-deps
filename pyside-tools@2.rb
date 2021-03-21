class PysideToolsAT2 < Formula
  desc "PySide development tools (pyuic and pyrcc)"
  homepage "https://wiki.qt.io/PySide2"
  url "http://code.qt.io/pyside/pyside-setup.git", :using => :git, :branch => "5.15.2"
  version "5.15.2"
  head "http://code.qt.io/pyside/pyside-setup.git", :branch => "5.15.2" 

  depends_on "cmake" => :build
  depends_on "python@3.9" => :build
  depends_on "pyside@2"

  def install
      mkdir "macbuild3.9" do
        args = std_cmake_args
        args << "-DUSE_PYTHON_VERSION=3.8"
        args << "../sources/pyside2-tools"

        system "cmake", *args
        system "make", "-j#{ENV.make_jobs}", "install"
      end
  end
end
