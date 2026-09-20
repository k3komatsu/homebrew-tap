class Texflux < Formula
  desc "TeX-first, indentation-based preprocessor for LaTeX and Beamer"
  homepage "https://github.com/k3komatsu/TeXFlux"
  url "https://github.com/k3komatsu/TeXFlux/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "3b6b669b89e2973d2b40e98073ad563a1d5e66f9dfd5578a944a9688a1466456"
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
