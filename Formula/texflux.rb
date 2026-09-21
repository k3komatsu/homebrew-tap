class Texflux < Formula
  desc "TeX-first, indentation-based preprocessor for LaTeX and Beamer"
  homepage "https://github.com/k3komatsu/TeXFlux"
  url "https://github.com/k3komatsu/TeXFlux/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "a26a38da6c5ec124e7beadd1e093180ad063e72a31fb8cd2ea387361f8b1ea88"
  license "0BSD"

  bottle do
    root_url "https://ghcr.io/v2/k3komatsu/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ac2d7c8ef305bf6472831df5cd108ba1ea5af4e5b7bcf144b986f7b007c305a3"
    sha256 cellar: :any,                 x86_64_linux: "0ae097009f93a90226d3659198ea1e57f6eb40a662dd1c9ee76d831d365b37e9"
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
