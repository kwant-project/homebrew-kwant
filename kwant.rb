require 'formula'

class Kwant < Formula
  homepage 'www.kwant-project.org'
  url 'file:///tmp/kwant-1.0.tgz'
  sha1 '9593b7bb28634866500384fd8bd779ceb5c64559'

  depends_on :python => 'numpy'
  depends_on :python => 'scipy'
  depends_on :fortran
  depends_on 'tinyarray'
  depends_on 'mumps_seq'

  def patches
    # make a configuration file for the build
    DATA
  end

  def install
    inreplace "build.conf", "xxlibgfortranpathxx", "#{Formula.factory('gfortran').opt_prefix}/gfortran/lib"

    system python, "setup.py", "install", "--prefix=#{prefix}"
  end

  def caveats
    python.standard_caveats if python
  end
end

__END__
diff -rupN kwant/build.conf kwant-build.conf/build.conf
--- kwant/build.conf	1970-01-01 01:00:00.000000000 +0100
+++ kwant-build.conf/build.conf	2013-08-16 16:03:38.000000000 +0200
@@ -0,0 +1,6 @@
+[lapack]
+libraries =
+extra_link_args = -Wl,-framework -Wl,Accelerate
+[mumps]
+library_dirs = xxlibgfortranpathxx
+libraries = zmumps_seq mumps_common_seq pord_seq metis esmumps scotch scotcherr mpiseq gfortran
