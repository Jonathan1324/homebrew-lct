class LinkedAssembly < Formula
  desc "The linked-assembly toolchain"
  homepage "https://github.com/Jonathan1324/linked-assembly"
  license "BSD-3-Clause"
  version "0.1.0-alpha.2"

  stable do
    # Binary-URL abhängig von Architektur
    if Hardware::CPU.arm?
      url "https://github.com/Jonathan1324/linked-assembly/releases/download/v#{version}/linked-assembly-macos-arm64.tar.gz"
      sha256 "c86ca5b4793c26296f81f5acb309b48ed0ea40c394928f5e92174440a66f143e"
    else
      url "https://github.com/Jonathan1324/linked-assembly/releases/download/v#{version}/linked-assembly-macos-x86_64.tar.gz"
      sha256 "675a7b286d007cc3c3df714cde7d8a05eb2f0e0941c5c5f9e4466f6b3576dd66"
    end

    # Build-from-Source: Git-Tag
    if build.from_source?
      url "https://github.com/Jonathan1324/linked-assembly.git",
          tag: "v#{version}"
    end
  end

  head do
    url "https://github.com/Jonathan1324/linked-assembly.git", branch: "main"
  end

  depends_on "rust" => :build if build.from_source?
  depends_on "nasm" => :build if build.from_source?
  depends_on "python@3.12" => :build if build.from_source?
  depends_on "make" => :build if build.from_source?
  depends_on "gcc" => :build if build.from_source?

  def install
    if build.from_source?
      arch_flag = Hardware::CPU.arm? ? "arm64" : "x86_64"

      system "cargo", "install", "cargo-download"
      system "cargo", "install", "cargo-license"

      system "python3", "-m", "ci.ci",
                        "--no-test",
                        "--no-log",
                        "--os", "macos",
                        "--arch", arch_flag

      cp_r Dir["dist/*"], prefix
    else
      # Entpacke das passende Binary
      system "tar", "-xzf", cached_download, "-C", prefix

      # Quarantine entfernen
      system "xattr", "-dr", "com.apple.quarantine", prefix
    end
  end

  test do
    Dir["#{prefix}/bin/*"].each do |exe|
        system exe, "--version"
    end
  end
end
