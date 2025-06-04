FROM golang:1.18-bullseye AS builder
WORKDIR /usr/src/app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app-binary .

FROM scratch
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/app-binary .

EXPOSE 8080
ENV ENV_VAR=production
CMD ["./app-binary", "serve"]
