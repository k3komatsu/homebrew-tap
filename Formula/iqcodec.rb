class Iqcodec < Formula
  desc "Lossless compression for SDR IQ captures (fc32/sc16)"
  homepage "https://github.com/k3komatsu/iqcodec"
  url "https://github.com/k3komatsu/iqcodec/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f9f4905b465d789fbf364d27020d669e3036ba6c6739b6b336537bb29e39ad64"
  license "MIT"

  def install
    system "make", "CC=#{ENV.cc}", "iqcodec"
    bin.install "iqcodec"
  end

  test do
    assert_match "iqcodec #{version}", shell_output("#{bin}/iqcodec -V")
    data = Random.new(1).bytes(1 << 18) # arbitrary sc16 samples
    (testpath/"in.sc16").binwrite(data)
    system bin/"iqcodec", "c", "-f", "sc16", "in.sc16", "out.iqc"
    system bin/"iqcodec", "d", "out.iqc", "back.sc16"
    assert_equal data, (testpath/"back.sc16").binread
  end
end
