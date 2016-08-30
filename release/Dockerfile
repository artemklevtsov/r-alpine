FROM alpine:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

ENV R_VERSION 3.3.1

RUN apk --no-cache add gcc gfortran g++ make readline-dev ncurses icu-dev \
    libjpeg-turbo-dev libpng-dev tiff-dev bzip2-dev pcre-dev xz-dev curl-dev \
    file coreutils zip perl wget \
    && cd /tmp \
    && wget https://cran.r-project.org/src/base/R-${R_VERSION%%.*}/R-${R_VERSION}.tar.gz \
    && tar -xf R-${R_VERSION}.tar.gz \
    && cd R-${R_VERSION} \
    && CXXFLAGS="$CXXFLAGS -D__MUSL__" ./configure \
                --prefix=/usr \
                --sysconfdir=/etc/R \
                --localstatedir=/var \
                --libdir=/usr/lib \
                rdocdir=/usr/share/doc/R \
                rincludedir=/usr/include/R \
                rsharedir=/usr/share/R \
                --disable-nls \
                --disable-java \
                --without-x \
                --without-recommended-packages \
                --enable-R-shlib \
    && make \
    && make install \
    && cd src/nmath/standalone \
    && make \
    && make install \
    && cd /tmp \
    && mkdir -p /etc/R \
    && mkdir -p /usr/local/lib/R/site-library \
    && echo "R_LIBS=\${R_LIBS-'/usr/local/lib/R/site-library:/usr/lib/R/library'}" >> /usr/lib/R/etc/Renviron \
    && echo 'options(repos = c(CRAN = "https://cloud.r-project.org/"))' >> /usr/lib/R/etc/Rprofile.site \
    && ln -s /usr/lib/R/etc/* /etc/R/ \
    && rm -rf /usr/lib/R/library/translations \
    && rm -rf /tmp/*

CMD ["R"]
