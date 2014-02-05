require 'formula'

class Tinyarray < Formula
  homepage 'kwant-project.org'
  url 'http://downloads.kwant-project.org/tinyarray/tinyarray-1.0.2.tar.gz'
  sha1 '953c102dabb7fbc28d3def8da4184e8cf9663995'

  depends_on :python

  def install
    system python, "setup.py", "install", "--prefix=#{prefix}"
  end

end
