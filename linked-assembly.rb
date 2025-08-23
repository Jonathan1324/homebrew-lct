class LinkedAssembly < Formula
  desc "The linked-assembly toolchain"
  homepage "https://github.com/Jonathan1324/linked-assembly"
  license "BSD-3-Clause"
  version "0.1.0-alpha.2"

  url "https://github.com/Jonathan1324/linked-assembly.git",
      tag:      "v0.1.0-alpha.2",
      revision: "c6851550f80c3f46eb62ad8890d889f4d3e00a91"

  depends_on "rust" => :build
  depends_on "nasm" => :build
  depends_on "python@3.12" => :build
  depends_on "make" => :build
  depends_on "gcc" => :build

  def install
    arch_flag = if Hardware::CPU.arm?
                  "arm64"
                else
                  "x86_64"
                end

    system "python3", "-m", "ci.ci",
                      "--no-test",
                      "--no-log",
                      "--os", "macos",
                      "--arch", arch_flag

    cp_r Dir["dist/*"], prefix
  end

  test do
    Dir["#{prefix}/bin/*"].each do |exe|
        system exe, "--version"
    end
  end
end
