class Libbluray < Formula
  homepage "https://www.videolan.org/developers/libbluray.html"
  url "ftp://ftp.videolan.org/pub/videolan/libbluray/0.7.0/libbluray-0.7.0.tar.bz2"
  sha1 "12baf71accac2ae9efe7fb077999821ea1430d7b"

  bottle do
    cellar :any
    revision 1
    sha1 "a223bd0799d7dc26a05ad0d5751569c4964c248e" => :yosemite
    sha1 "050786aa8393d98e0e72249f4933efa590c69a17" => :mavericks
    sha1 "9170f553e8df68758d0ccddea706b1b2b0e16109" => :mountain_lion
  end

  head do
    url "git://git.videolan.org/libbluray.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "ant" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "freetype" => :recommended
  depends_on "fontconfig"

  def install
    # https://mailman.videolan.org/pipermail/libbluray-devel/2014-April/001401.html
    ENV.append_to_cflags "-D_DARWIN_C_SOURCE"
    ENV.libxml2

    args = %W[--prefix=#{prefix} --disable-dependency-tracking]
    args << "--without-freetype" if build.without? "freetype"

    system "./bootstrap" if build.head?
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
