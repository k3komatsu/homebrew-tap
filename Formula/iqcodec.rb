class Iqcodec < Formula
  desc "Lossless compression for SDR IQ captures (fc32/sc16)"
  homepage "https://github.com/k3komatsu/iqcodec"
  url "https://github.com/k3komatsu/iqcodec/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "00821c2b890c638c704a52954c0e6e5e08bb6b2439fc109ea340e690651a2b83"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/k3komatsu/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ee4b2983ed5526bffc419b13ca62d914e806643e516d6b10f45d7f3787217d60"
    sha256 cellar: :any,                 x86_64_linux: "90101daf75f81ebd0350b01d0c2931f0623024d8bb691ea779a7f9814f1b5e66"
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
    system bin/"iqcodec", "d", "out.iqc", "back.sc16"
    assert_equal data, (testpath/"back.sc16").binread
  end
end
