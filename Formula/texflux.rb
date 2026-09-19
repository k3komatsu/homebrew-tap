class Texflux < Formula
  desc "TeX-first, indentation-based preprocessor for LaTeX and Beamer"
  homepage "https://github.com/k3komatsu/TeXFlux"
  url "https://github.com/k3komatsu/TeXFlux/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "91189ee68197d99301ebdf7705258eab6a62e753e3ebfe198a04331983f59dcc"
  license "0BSD"

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
