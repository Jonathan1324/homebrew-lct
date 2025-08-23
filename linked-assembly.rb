class LinkedAssembly < Formula
  desc "The linked-assembly toolchain"
  homepage "https://github.com/Jonathan1324/linked-assembly"
  license "BSD-3-Clause"
  version "0.1.0-alpha.2"

  if Hardware::CPU.arm?
    url "https://github.com/Jonathan1324/linked-assembly/releases/download/v#{version}/linked-assembly-macos-arm64.tar.gz"
    sha256 "c86ca5b4793c26296f81f5acb309b48ed0ea40c394928f5e92174440a66f143e"
  else
    url "https://github.com/Jonathan1324/linked-assembly/releases/download/v#{version}/linked-assembly-macos-x86_64.tar.gz"
    sha256 "675a7b286d007cc3c3df714cde7d8a05eb2f0e0941c5c5f9e4466f6b3576dd66"
  end

  def install
    system "tar", "-xzf", cached_download, "-C", prefix

    system "xattr", "-dr", "com.apple.quarantine", prefix
  end

  test do
    Dir["#{prefix}/bin/*"].each do |exe|
        system exe, "--version"
    end
  end
end
