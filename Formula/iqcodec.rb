class Iqcodec < Formula
  desc "Lossless compression for SDR IQ captures (fc32/sc16)"
  homepage "https://github.com/k3komatsu/iqcodec"
  url "https://github.com/k3komatsu/iqcodec/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "4c01521d89c9091082c488af8b3df89017874cd2f8cb16b6471c54660dcf9ad1"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/k3komatsu/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ea600c824f59c91203179bf27e8d1fd1d89781e1472b67006f746f8c049fba1c"
    sha256 cellar: :any,                 x86_64_linux: "c4b657e3b28b73eb0804e8bce0323e58fae20253f30035d527d5cc9e58be7d72"
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
