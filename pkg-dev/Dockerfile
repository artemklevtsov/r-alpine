FROM registry.gitlab.com/artemklevtsov/r-alpine:latest

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

RUN Rscript -e 'install.packages(c("devtools", "roxygen2", "testthat", "RUnit", "lintr", "covr"))'

CMD ['R']
