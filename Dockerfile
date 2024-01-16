FROM golang:1.19-alpine as builder

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
    apk --no-cache add git
ADD littlebox /app
WORKDIR /app
RUN GOOS=linux GOPROXY=https://goproxy.cn,direct go build .


FROM alpine:3.19 as prod

WORKDIR /app
COPY --from=0 /app/littlebox .

ENTRYPOINT ["/app/littlebox"]