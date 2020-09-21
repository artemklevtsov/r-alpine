FROM alpine:latest AS builder

RUN apk add --no-cache wget musl-dev zlib-dev ghc cabal && \
    cabal update && \
    cabal install -fstatic -fembed_data_files --constraint="base16-bytestring < 1" -j pandoc && \
    cabal install -fstatic -fembed_data_files -funicode_collation -j pandoc-citeproc && \
    strip /root/.cabal/bin/pandoc

FROM alpine:latest

COPY --from=builder /root/.cabal/bin/pandoc /usr/bin/pandoc
COPY --from=builder /root/.cabal/bin/pandoc-citeproc /usr/bin/pandoc-citeproc

ENTRYPOINT [" /usr/bin/pandoc"]

CMD ["/bin/ash"]
