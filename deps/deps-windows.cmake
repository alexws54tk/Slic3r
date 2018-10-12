
ExternalProject_Add("dep_boost_${DEPS_BITS}"
    EXCLUDE_FROM_ALL 1
    URL "https://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.gz"
    URL_HASH SHA256=bd0df411efd9a585e5a2212275f8762079fed8842264954675a4fddc46cfcf60
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ./bootstrap.sh
    BUILD_COMMAND ./b2
        -j "$NPROC"
        --with-system
        --with-filesystem
        --with-thread
        --with-log
        --with-locale
        --with-regex
        "--prefix=${INSTALL_DIR}/usr/local"
        "address-model=${DEPS_BITS}"
        toolset=msvc-12.0
        link=static
        variant=release
        threading=multi
        boost.locale.icu=off
        install
    INSTALL_COMMAND ""   # b2 does that already
)


if ($DEPS_BITS EQUAL 32)
    set(DEP_TBB_GEN "Visual Studio 12")
else ()
    set(DEP_TBB_GEN "Visual Studio 12 Win64")
endif ()

ExternalProject_Add("dep_tbb_${DEPS_BITS}"
    EXCLUDE_FROM_ALL 1
    URL "https://github.com/wjakob/tbb/archive/a0dc9bf76d0120f917b641ed095360448cabc85b.tar.gz"
    URL_HASH SHA256=0545cb6033bd1873fcae3ea304def720a380a88292726943ae3b9b207f322efe
    BUILD_IN_SOURCE 1
    CMAKE_ARGS -G "${DEP_TBB_GEN}"
        -DCMAKE_CONFIGURATION_TYPES=Release
        -DTBB_BUILD_SHARED=OFF
        -DTBB_BUILD_TESTS=OFF
        "-DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_DIR}\\usr\\local"
    BUILD_COMMAND msbuild /P:Configuration=Release INSTALL.vcxproj
    INSTALL_COMMAND ""
)

# ExternalProject_Add(dep_libcurl
#     EXCLUDE_FROM_ALL 1
#     DEPENDS dep_libopenssl
#     URL "https://curl.haxx.se/download/curl-7.58.0.tar.gz"
#     URL_HASH SHA256=cc245bf9a1a42a45df491501d97d5593392a03f7b4f07b952793518d97666115
#     BUILD_IN_SOURCE 1
#     CONFIGURE_COMMAND ./configure
#         --enable-static
#         --disable-shared
#         --with-ssl=$(DESTDIR)/usr/local
#         --with-pic
#         --enable-ipv6
#         --enable-versioned-symbols
#         --enable-threaded-resolver
#         --with-random=/dev/urandom
#         --with-ca-bundle=/etc/ssl/certs/ca-certificates.crt
#         --disable-ldap
#         --disable-ldaps
#         --disable-manual
#         --disable-rtsp
#         --disable-dict
#         --disable-telnet
#         --disable-pop3
#         --disable-imap
#         --disable-smb
#         --disable-smtp
#         --disable-gopher
#         --disable-crypto-auth
#         --without-gssapi
#         --without-libpsl
#         --without-libidn2
#         --without-gnutls
#         --without-polarssl
#         --without-mbedtls
#         --without-cyassl
#         --without-nss
#         --without-axtls
#         --without-brotli
#         --without-libmetalink
#         --without-libssh
#         --without-libssh2
#         --without-librtmp
#         --without-nghttp2
#         --without-zsh-functions-dir
#     BUILD_COMMAND make "-j${NPROC}"
#     INSTALL_COMMAND make install "DESTDIR=${INSTALL_DIR}"
# )

# ExternalProject_Add(dep_wxwidgets
#     EXCLUDE_FROM_ALL 1
#     URL "https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.1/wxWidgets-3.1.1.tar.bz2"
#     URL_HASH SHA256=c925dfe17e8f8b09eb7ea9bfdcfcc13696a3e14e92750effd839f5e10726159e
#     BUILD_IN_SOURCE 1
#     CONFIGURE_COMMAND ./configure
#         "--prefix=${INSTALL_DIR}/usr/local"
#         --disable-shared
#         --with-gtk=2
#         --with-opengl
#         --enable-unicode
#         --enable-graphics_ctx
#         --with-regex=builtin
#         --with-libpng=builtin
#         --with-libxpm=builtin
#         --with-libjpeg=builtin
#         --with-libtiff=builtin
#         --with-zlib=builtin
#         --with-expat=builtin
#         --disable-precomp-headers
#         --enable-debug_info
#         --enable-debug_gdb
#     BUILD_COMMAND make "-j${NPROC}" && make -C locale allmo
#     INSTALL_COMMAND make install
# )
