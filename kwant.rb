require 'formula'

class Kwant < Formula
  homepage 'www.kwant-project.org'
  url 'downloads.kwant-project.org/kwant/kwant-1.0.2.tar.gz'
  sha1 'bf35f4c46d4ae5ae639b7c4e831348216551ea0c'

  depends_on 'numpy' => :python
  depends_on 'scipy' => :python
  depends_on :fortran
  depends_on 'tinyarray'
  depends_on 'mumps_seq'

  def patches
    # make a configuration file for the build
    DATA
  end

  def install
    # Locate gfortran library
    libgfortran = `$FC --print-file-name libgfortran.a`.chomp

    inreplace "build.conf", "xxlibgfortranpathxx", "#{File.dirname libgfortran}"

    system "python", "setup.py", "install", "--prefix=#{prefix}"
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
