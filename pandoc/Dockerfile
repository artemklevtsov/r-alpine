FROM alpine:edge AS build-pandoc

RUN apk add --no-cache gmp libffi musl-dev zlib-dev linux-headers ghc cabal && \
    cabal update && \
    cabal install hsb2hs && \
    cabal install pandoc -fembed_data_files && \
    cabal install pandoc-citeproc -fembed_data_files

FROM registry.gitlab.com/artemklevtsov/r-alpine/r-release:latest

COPY --from=build-pandoc /root/.cabal/bin/pandoc /usr/bin/pandoc
COPY --from=build-pandoc/root/.cabal/bin/pandoc-citeproc /usr/bin/pandoc-citeproc

CMD ["R"]
