FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . .

FROM scratch 
WORKDIR /
COPY --from=builder /go/src/app/test_app .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./test_app"]