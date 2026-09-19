class Texflux < Formula
  desc "TeX-first, indentation-based preprocessor for LaTeX and Beamer"
  homepage "https://github.com/k3komatsu/TeXFlux"
  url "https://github.com/k3komatsu/TeXFlux/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "c7329a1d37aaa11c5a6dfee455d13bea8b30d3ecac97a1ea668bae9676813f5b"
  license "0BSD"

  bottle do
    root_url "https://ghcr.io/v2/k3komatsu/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "700ae56c32c888cc5ae95b52c6c144fdeb0d660721a5b3bef3dba71fc5c80a6c"
    sha256 cellar: :any,                 x86_64_linux: "8b6081df9536b97ecb6d63d96a2add84ecc085159310d94d8be535eb4fbeafed"
  end

  depends_on "dub" => :build
  depends_on "ldc" => :build

  def install
    system "dub", "build", "--build=release"
    bin.install "bin/texflux"
  end

  test do
    assert_match "texflux #{version}", shell_output("#{bin}/texflux --version")
  end
end
