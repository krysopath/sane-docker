FROM golang:alpine AS initial
ENV PATH=/code/bin:$PATH
WORKDIR /code

COPY src/ ./src/
COPY bin/entry bin/
WORKDIR /code/src
RUN go build -o server .

FROM busybox AS release
COPY --from=initial /code/src/server /code/bin/server
COPY --from=initial /code/bin/entry /code/bin
USER 1000:1000
ENTRYPOINT ["/code/bin/entry"]
CMD ["/code/bin/server"]

FROM golang:alpine AS development
COPY --from=release / /
ENTRYPOINT ["ash"]

FROM golang:alpine AS test
COPY --from=release / /
RUN echo go test ...
RUN sleep 1m

