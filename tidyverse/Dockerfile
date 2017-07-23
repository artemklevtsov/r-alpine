FROM registry.gitlab.com/artemklevtsov/r-alpine:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

RUN apk --no-cache add \
        libxml2-dev \
        libressl-dev \
        sqlite-dev \
        mariadb-dev \
        postgresql-dev \
    && Rscript -e 'install.packages(c("RSQLite", "RMySQL", "RPostgreSQL"))' \
    && Rscript -e 'install.packages("tidyverse")'

CMD ['R']
