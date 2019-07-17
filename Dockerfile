FROM alpine:latest AS base

ARG VERSION="TCP-3.0.9c"
WORKDIR /data

RUN apk --update add --no-cache curl unzip
RUN echo "Downloading: http://files.theclassicpack.com/SERVER/${VERSION}_SERVER.zip" && curl -s "http://files.theclassicpack.com/SERVER/${VERSION}_SERVER.zip" -o SERVER.zip
RUN unzip SERVER.zip && rm SERVER.zip

FROM openjdk:8-jre-alpine

WORKDIR /data

COPY --from=base /data /data
COPY /server/* /data/
COPY launch.sh /data/launch.sh
RUN chmod +x /data/launch.sh
RUN mkdir -p mods/disabled

ENTRYPOINT ["./launch.sh"]
