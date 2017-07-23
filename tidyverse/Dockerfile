FROM registry.gitlab.com/artemklevtsov/r-alpine/r-release:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

RUN apk --no-cache add \
        libxml2-dev \
        libressl-dev \
        sqlite-dev \
        mariadb-dev \
        postgresql-dev \
    && Rscript -e 'install.packages(c("tidyverse"))' \
    && Rscript -e 'install.packages(c("RSQLite", "RMySQL", "RPostgreSQL", "dbplyr"))' \
    && Rscript -e 'install.packages(c("data.table", "dtplyr"))'

CMD ['R']
