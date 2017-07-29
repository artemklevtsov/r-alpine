FROM registry.gitlab.com/artemklevtsov/r-alpine/r-release:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

RUN apk --no-cache add \
        gmp \
        libffi \
        cmake \
        wget \
        python2 \
        libxml2-dev \
        libressl-dev \
        linux-headers && \
    Rscript -e 'install.packages(c("rmarkdown", "shiny"))' && \
    cd /tmp && \
    wget --no-check-certificate https://github.com/rstudio/shiny-server/archive/master.tar.gz && \
    tar -zxf master.tar.gz && \
    cd /tmp/shiny-server-master && \
    mkdir tmp && \
    cd tmp && \
    PATH=$PWD/../bin:$PATH && \
    PYTHON=`which python` && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/lib -DPYTHON="$PYTHON" ../ && \
    make && \
    mkdir ../build && \
    (cd .. && ./bin/npm --python="$PYTHON" install) && \
    (cd .. && ./bin/node ./ext/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js --python="$PYTHON" rebuild)  &&\
    make install && \
    ln -s /usr/lib/shiny-server/bin/shiny-server /usr/bin/shiny-server && \
    ln -s /usr/lib/shiny-server/ext/pandoc/pandoc /usr/bin/pandoc && \
    ln -s /usr/lib/shiny-server/ext/pandoc/pandoc-citeproc /usr/bin/pandoc-citeproc && \
    rm -rf /tmp/* && \
    mkdir -p /srv/shiny-server && \
    mkdir -p /var/lib/shiny-server && \
    addgroup -S shiny && \
    adduser -h /srv/shiny-server -G shiny -S shiny && \
    mkdir -p /var/log/shiny-server && \
    chown shiny:shiny /var/log/shiny-server && \
    apk del cmake wget python2 linux-headers

EXPOSE 3838

VOLUME ["/srv/shiny-server"]

COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

CMD ["/usr/bin/shiny-server"]
