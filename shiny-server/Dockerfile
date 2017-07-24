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
        linux-headers \
    && Rscript -e 'install.packages(c("rmarkdown", "shiny"))' \
    && cd /tmp \
    && wget --no-check-certificate https://github.com/rstudio/shiny-server/archive/master.tar.gz \
    && tar -zxf master.tar.gz \
    && cd /tmp/shiny-server-master \
    && PATH=$PWD/../bin:$PATH \
    && PYTHON=`which python` \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DPYTHON="$PYTHON" ../
    && make \
    && mkdir ../build \
    && (cd .. && ./bin/npm --python="$PYTHON" install)
    && (cd .. && ./bin/node ./ext/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js --python="$PYTHON" rebuild) \
    && make install \
    && ln -s /usr/local/shiny-server/ext/pandoc/pandoc /usr/local/bin/pandoc \
    && ln -s /usr/local/shiny-server/ext/pandoc/pandoc-citeproc /usr/local/bin/pandoc-citeproc \
    && rm -f /tmp/master.tar.gz \
    && rm -rf /tmp/shiny-server-master \
    && mkdir -p /srv/shiny-server \
    && adduser -h /srv/shiny-server -S shiny shiny \
    && apk del cmake wget python2 linux-headers

EXPOSE 3838

VOLUME ["/srv/shiny-server"]

COPY shiny-server.conf /etc/shiny-server/shiny-server.conf
COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]
