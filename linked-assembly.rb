class LinkedAssembly < Formula
  desc "The linked-assembly toolchain"
  homepage "https://github.com/Jonathan1324/linked-assembly"
  license "BSD-3-Clause"
  version "0.1.0-alpha.2"

  url "https://github.com/Jonathan1324/linked-assembly.git",
      tag:      "v0.1.0-alpha.2",
      revision: "PUT_ACTUAL_COMMIT_HASH_HERE"

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
