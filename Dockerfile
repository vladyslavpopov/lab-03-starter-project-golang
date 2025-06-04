FROM golang:1.18-bullseye AS builder
WORKDIR /usr/src/app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app-binary .

FROM gcr.io/distroless/base
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/app-binary .
EXPOSE 8080
CMD ["./app-binary", "serve"]
