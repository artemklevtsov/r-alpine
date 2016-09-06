FROM alpine:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

RUN apk --no-cache add build-base gfortran readline-dev \
    icu-dev bzip2-dev xz-dev pcre-dev libjpeg-turbo-dev libpng-dev tiff-dev \
    curl-dev file coreutils bash \
    && apk --no-cache add --virtual build-deps \
    wget rsync perl autoconf automake openjdk8-jre-base cairo-dev pango-dev \
    && cd /tmp \
    && wget https://stat.ethz.ch/R/daily/R-devel.tar.gz \
    && tar -xf R-devel.tar.gz \
    && cd R-devel \
    && tools/rsync-recommended \
    && CXXFLAGS="$CXXFLAGS -D__MUSL__" ./configure \
                --prefix=/usr \
                --sysconfdir=/etc/R \
                --localstatedir=/var \
                --libdir=/usr/lib \
                rdocdir=/usr/share/doc/R \
                rincludedir=/usr/include/R \
                rsharedir=/usr/share/R \
                --disable-nls \
                --without-x \
                --without-recommended-packages \
                --enable-R-shlib \
    && make \
    && make install \
    && cd src/nmath/standalone \
    && make shared \
    && make install \
    && apk del --purge --rdepends build-deps \
    && rm -f /usr/lib/R/bin/R \
    && ln -s //usr/bin/R /usr/lib/R/bin/R \
    && echo "R_LIBS_SITE=\${R_LIBS_SITE-'/usr/local/lib/R/site-library:/usr/lib/R/library'}" >> /usr/lib/R/etc/Renviron \
    && echo 'options(repos = c(CRAN = "https://cloud.r-project.org/"))' >> /usr/lib/R/etc/Rprofile.site \
    && mkdir -p /etc/R \
    && ln -s /usr/lib/R/etc/* /etc/R/ \
    && mkdir -p /usr/local/lib/R/site-library \
    && chgrp users /usr/local/lib/R/site-library \
    && rm -rf /usr/lib/R/library/translations \
    && rm -rf /tmp/*

CMD ["R"]
