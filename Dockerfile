FROM quay.io/projectquay/golang:1.20
WORKDIR /go/src/app
COPY . .

RUN make build
ENTRYPOINT ["./hello"]