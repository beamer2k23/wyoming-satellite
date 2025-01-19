FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --yes --no-install-recommends avahi-utils

RUN .venv/bin/pip3 install 'pysilero-vad==1.0.0' 'webrtc-noise-gain==1.2.3'

WORKDIR /app

COPY sounds/ ./sounds/
COPY script/setup ./script/
COPY setup.py requirements.txt MANIFEST.in ./
COPY wyoming_satellite/ ./wyoming_satellite/

RUN script/setup

COPY script/run ./script/
COPY docker/run ./

EXPOSE 10700

ENTRYPOINT ["/app/run"]
