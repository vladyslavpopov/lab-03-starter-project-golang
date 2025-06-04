FROM golang:1.18-bullseye AS builder

WORKDIR /usr/src/app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o app-binary .

FROM golang:1.18-bullseye
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/app-binary .
EXPOSE 8080
CMD ["./app-binary"]
