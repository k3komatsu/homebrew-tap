class Iqcodec < Formula
  desc "Lossless compression for SDR IQ captures (fc32/sc16)"
  homepage "https://github.com/k3komatsu/iqcodec"
  url "https://github.com/k3komatsu/iqcodec/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "41d766b1d3a7b0986f9861d4705826e408542e6f6d86e74c7d3f598996f96da6"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/k3komatsu/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f20671df5111543b04abeb20eac49a4b0d09d8b5681ab5f199be82385749ef81"
    sha256 cellar: :any,                 x86_64_linux: "c03707b0ca99e08a22836610e97c431388c4e4e812df0c02ed383018aee6dd78"
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
