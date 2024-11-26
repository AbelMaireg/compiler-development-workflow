FROM debian:stable-20241111

WORKDIR /workspace

RUN apt update && apt install bison flex vim make tree -y
