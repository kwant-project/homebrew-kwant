require 'formula'

class MumpsSeq < Formula
  homepage 'http://graal.ens-lyon.fr/MUMPS/'
  url 'http://mumps.enseeiht.fr/MUMPS_4.10.0.tar.gz'
  sha1 '904b1d816272d99f1f53913cbd4789a5be1838f7'

  depends_on 'scotch5'
  depends_on 'metis4'
  depends_on :fortran

  keg_only "Dependency of kwant, might be some day in homebrew-science"

  option "with-test" "Run the example programs included in Mumps"
  def install
    ENV.j1

    system "cp Make.inc/Makefile.gfortran.SEQ Makefile.inc"
    inreplace 'Makefile.inc' do |s|
      s.change_make_var! "ORDERINGSF", "-Dpord -Dmetis -Dscotch"
      s.change_make_var! "CC", ENV['CC']
      s.change_make_var! "FC", ENV['FC']
      s.change_make_var! "FL", ENV['FC']
      s.change_make_var! "LIBBLAS", "-lblas"
      s.change_make_var! "LORDERINGS", "$(LPORD) -lmetis -lesmumps -lscotch -lscotcherrexit"
      s.change_make_var! "IORDERINGSF", ""
      s.change_make_var! "IORDERINGSF", "$(IPORD)"
    end

    system "make", "all"

    # make names as in Debian (sequential version has _seq at end of filename)
    mv "lib/libmumps_common.a", "lib/libmumps_common_seq.a"
    mv "lib/libsmumps.a", "lib/libsmumps_seq.a"
    mv "lib/libdmumps.a", "lib/libdmumps_seq.a"
    mv "lib/libcmumps.a", "lib/libcmumps_seq.a"
    mv "lib/libzmumps.a", "lib/libzmumps_seq.a"
    mv "lib/libpord.a", "lib/libpord_seq.a"

    lib.install Dir['lib/*.a', 'libseq/*.a']
    include.install Dir['include/*.h']

    if build.with? 'test'
      cd 'examples'
      system "./ssimpletest", "<input_simpletest_real"
      system "./dsimpletest", "<input_simpletest_real"
      system "./csimpletest", "<input_simpletest_cmplx"
      system "./zsimpletest", "<input_simpletest_cmplxx"
    end
  end
end
