class Iqcodec < Formula
  desc "Lossless compression for SDR IQ captures (fc32/sc16)"
  homepage "https://github.com/k3komatsu/iqcodec"
  url "https://github.com/k3komatsu/iqcodec/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "cbe53684042e8d1dba694aa7f7892f1b530a5427f60c14a36b3ab2e142667673"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/k3komatsu/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a485273a117c24277af7e524082be515615e13ddeae16a77348494c2c45539ff"
    sha256 cellar: :any,                 x86_64_linux: "1827b253547f342af53336233432f53fc137bba4ebb09d56724761e0612fb477"
  end

  def install
    system "make", "CC=#{ENV.cc}", "iqcodec"
    bin.install "iqcodec"
  end

  test do
    assert_match "iqcodec #{version}", shell_output("#{bin}/iqcodec -V")
    data = Random.new(1).bytes(1 << 18) # arbitrary sc16 samples
    (testpath/"in.sc16").binwrite(data)
    system bin/"iqcodec", "c", "-t", "-f", "sc16", "in.sc16", "out.iqc"
    system bin/"iqcodec", "t", "out.iqc"
    assert_match "samples  65536", shell_output("#{bin}/iqcodec i out.iqc")
    system bin/"iqcodec", "d", "out.iqc", "back.sc16"
    assert_equal data, (testpath/"back.sc16").binread
  end
end
