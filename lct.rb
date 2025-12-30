class Lct < Formula
  desc "LCT is a toolset."
  homepage "https://github.com/Jonathan1324/lct"
  license "BSD-3-Clause"
  version "0.1.0-alpha.5"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Jonathan1324/lct/releases/download/v#{version}/lct-macos-arm64.tar.gz"
      sha256 "57a3513abb18f8326757bc9173f111dc88ad050b2aa177ed922a6075649438de"
    else
      url "https://github.com/Jonathan1324/lct/releases/download/v#{version}/lct-macos-x86_64.tar.gz"
      sha256 "82484c8f27d1600ba2bf837bd827f3ae3411e85fb4de1897e1421b1b9cf5f340"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Jonathan1324/lct/releases/download/v#{version}/lct-linux-arm64.tar.gz"
      sha256 "541c51224b63c997cc41b2e7a7a6951451f7373e82601240a557ef1431ec3e23"
    else
      url "https://github.com/Jonathan1324/lct/releases/download/v#{version}/lct-linux-x86_64.tar.gz"
      sha256 "eb0e2e9039024f732ec4651c1232939e25486223c9fa7c75a24ad8c641e1fb11"
    end
  end

  def install
    system "tar", "-xzf", cached_download, "-C", prefix
    system "xattr", "-dr", "com.apple.quarantine", prefix if OS.mac?
  end

  test do
    Dir["#{prefix}/bin/*"].each do |exe|
      system exe, "--version"
    end
  end
end
