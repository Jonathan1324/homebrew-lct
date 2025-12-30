class Lct < Formula
  desc "LCT is a toolset."
  homepage "https://github.com/Jonathan1324/lct"
  license "BSD-3-Clause"
  version "0.1.0-alpha.5"

  url "https://github.com/Jonathan1324/lct/archive/refs/tags/v#{version}.tar.gz"
  sha256 "787dfb511388006363c5d58048ce68d1d1bc3f3a7664321b5e73097d5d3933a1"

  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on "rust" => :build
  depends_on "python@3.12" => :build

  def install
    system "cargo", "install", "cargo-license"

    system "python3", "-m", "ci.ci", "--no-test"

    libexec.install Dir["dist/*"]

    bin.install Dir["#{libexec}/bin/*"]
  end

  test do
    Dir["#{prefix}/bin/*"].each do |exe|
      system exe, "--version"
    end
  end
end
