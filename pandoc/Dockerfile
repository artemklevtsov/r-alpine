FROM alpine:latest AS build-pandoc

RUN apk add --no-cache gmp libffi musl-dev zlib-dev linux-headers ghc cabal && \
    cd /tmp && \
    cabal update && \ 
    cabal install hsb2hs && \
    cabal install pandoc -fembed_data_files && \
    cabal install pandoc-citeproc -fembed_data_files && \
    rm -rf /root/.cabal && \
    apk del ghc cabal musl-dev zlib-dev linux-headers

FROM alpine:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

ARG R_VERSION

# R version
ENV R_VERSION ${R_VERSION:-3.4.1}

# R runtime dependencies
RUN apk --no-cache add \
        gcc \
        gfortran \
        g++ \
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
    && curl -O https://cran.r-project.org/src/base/R-${R_VERSION:0:1}/R-${R_VERSION}.tar.gz \
# Extract source code
    && tar -xf R-${R_VERSION}.tar.gz \
    && cd R-${R_VERSION} \
# Sect compiler flags
    && CFLAGS="-g -O2 -D_DEFAULT_SOURCE -D__USE_MISC" \
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
                   --enable-R-shlib \
# Build and install R
    && make \
    && make install \
    && cd src/nmath/standalone \
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

COPY --from=build-pandoc /root/.cabal/bin/pandoc /usr/bin/pandoc
COPY --from=build-pandoc/root/.cabal/bin/pandoc-citeproc /usr/bin/pandoc-citeproc

CMD ["R"]
 