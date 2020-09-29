FROM alpine:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

ARG R_VERSION
ENV R_VERSION ${R_VERSION:-4.0.0}
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV CRAN https://cran.r-project.org
ENV R_DAILY_URL https://stat.ethz.ch/R/daily

    # R runtime dependencies
RUN apk --no-cache add \
        linux-headers \
        gcc \
        gfortran \
        g++ \
        make \
        readline-dev \
        icu-dev \
        zlib-dev \
        bzip2-dev \
        xz-dev \
        pcre-dev \
        pcre2-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        tiff-dev  \
        curl-dev \
        openblas-dev \
        zip \
        file \
        coreutils \
        bash && \
    # R build dependencies
    apk --no-cache add --virtual build-deps \
        perl \
        openjdk8-jre-base \
        libxmu-dev \
        pango-dev \
        cairo-dev \
        tcl-dev \
        tk-dev && \
    cd /tmp && \
    # Download source code
    if [[ "$R_VERSION" == "devel" ]]; then \
        wget ${R_DAILY_URL}/R-devel.tar.gz; \
    elif [[ "$R_VERSION" == "patched" ]]; then \
        wget ${R_DAILY_URL}/R-patched.tar.gz; \
    else \
        wget ${CRAN}/src/base/R-${R_VERSION%%.*}/R-${R_VERSION}.tar.gz; \
    fi && \
    # Extract source code
    tar -xf R-${R_VERSION}.tar.gz && \
    cd R-${R_VERSION} && \
    # Set compiler flags
    CFLAGS="-g -O2 -fstack-protector-strong -D_DEFAULT_SOURCE -D__USE_MISC" \
    CXXFLAGS="-g -O2 -fstack-protector-strong -D_FORTIFY_SOURCE=2 -D__MUSL__" \
    # configure script options
    ./configure --prefix=/usr \
                --sysconfdir=/etc/R \
                --localstatedir=/var \
                rdocdir=/usr/share/doc/R \
                rincludedir=/usr/include/R \
                rsharedir=/usr/share/R \
                --enable-memory-profiling \
                --enable-R-shlib \
                --enable-java \
                --disable-nls \
                --with-blas=openblas \
                --without-x \
                --without-recommended-packages && \
    # Build and install R
    make -j $(nproc) && \
    make install && \
    cd src/nmath/standalone && \
    make && \
    make install && \
    rm -f /usr/lib/R/bin/R && \
    ln -s /usr/bin/R /usr/lib/R/bin/R && \
    # Fix library path
    echo "R_LIBS_SITE=\${R_LIBS_SITE-'/usr/local/lib/R/site-library:/usr/lib/R/library'}" >> /usr/lib/R/etc/Renviron && \
    # Add default CRAN mirror
    echo "options(repos = c(CRAN = '${CRAN}'))" >> /usr/lib/R/etc/Rprofile.site && \
    # Add symlinks for the config ifile in /etc/R
    mkdir -p /etc/R && \
    ln -s /usr/lib/R/etc/* /etc/R/ && \
    # Add library directory
    mkdir -p /usr/local/lib/R/site-library && \
    chgrp users /usr/local/lib/R/site-library && \
    # Remove build dependencies
    apk del --purge --rdepends build-deps && \
    # Clean up
    rm -rf /usr/lib/R/library/translations && \
    rm -rf /tmp/*

CMD ["R"]
