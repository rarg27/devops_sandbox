FROM golang:1.15.2 as builder

ENV GOOS=linux GOARCH=amd64 CGO_ENABLED=0

WORKDIR /app

COPY . .

RUN go build -o canary

FROM busybox

WORKDIR /app

COPY --from=builder /app/canary ./

EXPOSE 8080

ENTRYPOINT ["./canary"]