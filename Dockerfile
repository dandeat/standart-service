# Create Builder Image
FROM golang:alpine AS builder
LABEL maintainer="MKP Mobile Krenzzz <mkpproduction@gmail.com>"

# Install Git for Dependencies
RUN apk add --no-cache git

# Set Working Directory
RUN mkdir /app
COPY . .

# Do Your Magic Here
#
#

# Build Go Binary File
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /app/main

# Create Second Image
FROM scratch

# Copy Binary File from Builder Image
COPY --from=builder /app/main /main
COPY --from=builder /app/.env /.env
COPY --from=builder /app/key /key

# Run Binary File
ENTRYPOINT ["/main"]
