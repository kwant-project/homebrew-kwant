require 'formula'

class Tinyarray < Formula
  homepage 'kwant-project.org'
  url 'http://downloads.kwant-project.org/tinyarray/tinyarray-1.0.2.tar.gz'
  sha256 'e196f56268c0b24254621fee12633632a8a33d1a3a1ad8742a8d8232810ee840'

  depends_on :python

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}"
  end

end
