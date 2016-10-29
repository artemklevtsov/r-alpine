FROM registry.gitlab.com/artemklevtsov/r-alpine:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

ENV R_PKG \
        devtools \
        roxygen2 \
        testthat \
        RUnit \
        lintr \
        covr

RUN Rscript -e 'install.packages(commandArgs(TRUE))' ${R_PKG}

CMD ['R']
