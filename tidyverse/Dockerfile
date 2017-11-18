FROM registry.gitlab.com/artemklevtsov/r-alpine/r-release:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

ENV APKGS libxml2-dev libressl-dev sqlite-dev mariadb-dev postgresql-dev
ENV RPKGS tidyverse RSQLite RMySQL RMariaDB RPostgreSQL dbplyr data.table dtplyr

RUN apk --no-cache add ${APKGS} && \
    Rscript -e 'install.packages(commandArgs(TRUE))' ${RPKGS}
