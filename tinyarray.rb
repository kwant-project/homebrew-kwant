require 'formula'

class Tinyarray < Formula
  homepage 'kwant-project.org'
  url 'http://kwant-project.org/tinyarray/tinyarray-1.0.tar.gz'
  sha1 'b73ba5ca4780b9641023af6ea31cd6833d2a2735'

  depends_on :python

  def install
    system python, "setup.py", "install", "--prefix=#{prefix}"
  end

  def caveats
    python.standard_caveats if python
  end
end
