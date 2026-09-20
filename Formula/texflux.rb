class Texflux < Formula
  desc "TeX-first, indentation-based preprocessor for LaTeX and Beamer"
  homepage "https://github.com/k3komatsu/TeXFlux"
  url "https://github.com/k3komatsu/TeXFlux/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "18816b76ce9cacb79a10b3859f188005a5863faf53594004820c80336c0cb44b"
  license "0BSD"

  bottle do
    root_url "https://ghcr.io/v2/k3komatsu/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2d6389dfc298bf13a557effea8cdbc43a596ea1f5e5533921c39d3d3f817c121"
    sha256 cellar: :any,                 x86_64_linux: "ecfdbb7819b865f015f0be1ea1fb41353f2fec1981e0227d137aa89ae8bd9f6d"
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
