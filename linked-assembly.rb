class LinkedAssembly < Formula
  desc "The linked-assembly toolchain"
  homepage "https://github.com/Jonathan1324/linked-assembly"
  license "BSD-3-Clause"
  version "0.1.0-alpha.4-christmas2025"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Jonathan1324/linked-assembly/releases/download/v#{version}/linked-assembly-macos-arm64.tar.gz"
      sha256 "5989998488f51f4382465ab60d4f0aa6d67586c6233d2d93da003e09495c57cd"
    else
      url "https://github.com/Jonathan1324/linked-assembly/releases/download/v#{version}/linked-assembly-macos-x86_64.tar.gz"
      sha256 "6ba08ddc402340ba912f2807f87a9b1a45bcb2d2df8b212f0a50e482438801d4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Jonathan1324/linked-assembly/releases/download/v#{version}/linked-assembly-linux-arm64.tar.gz"
      sha256 "b7e4a9d2669c46335f50ff5cdf36b9e05b3b5bc79ab130478ec5f841634b8aed"
    else
      url "https://github.com/Jonathan1324/linked-assembly/releases/download/v#{version}/linked-assembly-linux-x86_64.tar.gz"
      sha256 "14866965cca15ca2fe1c60aea8969dcfcaa116100abf2a7bdeca5222e6fb10a1"
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
