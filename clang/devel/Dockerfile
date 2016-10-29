FROM alpine:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

# R runtime dependencies
RUN apk --no-cache add \
        musl-dev \
        gfortran \
        g++ \
        clang \
        clang-dev \
        make \
        readline-dev \
        icu-dev \
        bzip2-dev \
        xz-dev \
        pcre-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        tiff-dev  \
        curl-dev \
        zip \
        file \
        coreutils \
        bash \
# R build dependencies
    && apk --no-cache add --virtual build-deps \
        curl \
        perl \
        openjdk8-jre-base \
        pango-dev \
        cairo-dev \
    && cd /tmp \
# Download source code
    && curl -O https://stat.ethz.ch/R/daily/R-devel.tar.gz \
# Extract source code
    && tar -xf R-devel.tar.gz \
    && cd R-devel \
# Sect compiler flags
    && CC=clang \
       CXX=clang++ \
       F77=gfortran \
       OBJC=clang \
       CFLAGS="-g -O2 -D_DEFAULT_SOURCE" \
       CXXFLAGS="-g -O2 -D__MUSL__" \
# configure script options
       ./configure --prefix=/usr \
                   --sysconfdir=/etc/R \
                   --localstatedir=/var \
                   rdocdir=/usr/share/doc/R \
                   rincludedir=/usr/include/R \
                   rsharedir=/usr/share/R \
                   --disable-nls \
                   --without-x \
                   --without-recommended-packages \
                   --enable-memory-profiling \
    && make \
    && make install \
# Remove build dependencies
    && apk del --purge --rdepends build-deps \
    && rm -f /usr/lib/R/bin/R \
    && ln -s /usr/bin/R /usr/lib/R/bin/R \
# Fis library path
    && echo "R_LIBS_SITE=\${R_LIBS_SITE-'/usr/local/lib/R/site-library:/usr/lib/R/library'}" >> /usr/lib/R/etc/Renviron \
# Add default CRAN mirror
    && echo 'options(repos = c(CRAN = "https://cloud.r-project.org/"))' >> /usr/lib/R/etc/Rprofile.site \
# Add symlinks for the config ifile in /etc/R
    && mkdir -p /etc/R \
    && ln -s /usr/lib/R/etc/* /etc/R/ \
# Add library directory
    && mkdir -p /usr/local/lib/R/site-library \
    && chgrp users /usr/local/lib/R/site-library \
# Clean up
    && rm -rf /usr/lib/R/library/translations \
    && rm -rf /tmp/*

CMD ["R"]
