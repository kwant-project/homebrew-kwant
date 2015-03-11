require 'formula'

class Tinyarray < Formula
  homepage 'kwant-project.org'
  url 'http://downloads.kwant-project.org/tinyarray/tinyarray-1.0.5.tar.gz'
  sha1 '8d802735027ca08793bab4fb37f2daa6c2fd0eaf'

  depends_on :python

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}"
  end

end
