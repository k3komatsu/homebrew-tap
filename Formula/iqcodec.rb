class Iqcodec < Formula
  desc "Lossless compression for SDR IQ captures (fc32/sc16)"
  homepage "https://github.com/k3komatsu/iqcodec"
  url "https://github.com/k3komatsu/iqcodec/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "4c01521d89c9091082c488af8b3df89017874cd2f8cb16b6471c54660dcf9ad1"
  license "MIT"

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
