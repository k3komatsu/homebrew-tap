class Texflux < Formula
  desc "TeX-first, indentation-based preprocessor for LaTeX and Beamer"
  homepage "https://github.com/k3komatsu/TeXFlux"
  url "https://github.com/k3komatsu/TeXFlux/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "18816b76ce9cacb79a10b3859f188005a5863faf53594004820c80336c0cb44b"
  license "0BSD"

  bottle do
    root_url "https://ghcr.io/v2/k3komatsu/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "861459384425767861326e0cb1be63036238077f8b5f6262f4b785b256fb4bd4"
    sha256 cellar: :any,                 x86_64_linux: "7e6f965aed47703cd594fca959dfc47dee58fb632206275e12878064b9e5acb0"
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
