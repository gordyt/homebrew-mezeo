require 'formula'

class HaskellPlatform741 < Formula
  homepage 'http://hackage.haskell.org/platform/'
  url 'http://lambda.haskell.org/platform/download/2012.2.0.0/haskell-platform-2012.2.0.0.tar.gz'
  sha1 '91405b8d864d35d90effb9aac3ad9309ea6d86a7'

  depends_on 'ghc-7.4.1'

  conflicts_with 'cabal-install'

  def install
    # libdir doesn't work if passed to configure, needs to be set in the environment
    system "./configure", "--prefix=#{prefix}"
    ENV['EXTRA_CONFIGURE_OPTS'] = "--libdir=#{lib}/ghc"
    system "make install"
  end

  def caveats; <<-EOS.undent
    Run `cabal update` to initialize the package list.

    If you are replacing a previous version of haskell-platform, you may want
    to unregister packages belonging to the old version. You can find broken
    packages using:
      ghc-pkg check --simple-output
    You can uninstall them using:
      ghc-pkg check --simple-output | xargs -n 1 ghc-pkg unregister --force
    EOS
  end
end
