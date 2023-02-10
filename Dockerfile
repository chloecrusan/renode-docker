# This docker configuration file lets you easily run Renode and simulate embedded devices
# on an x86 desktop or laptop. The framework can be used for debugging and automated testing.
FROM ubuntu:20.04

# Install main dependencies and some useful tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates sudo wget

ARG RENODE_VERSION=1.13.2

RUN wget https://github.com/renode/renode/releases/download/v${RENODE_VERSION}/renode_${RENODE_VERSION}_amd64.deb && \
    apt-get install -y --no-install-recommends ./renode_${RENODE_VERSION}_amd64.deb python3-dev && \
    rm ./renode_${RENODE_VERSION}_amd64.deb

RUN pip3 install -r /opt/renode/tests/requirements.txt --no-cache-dir
RUN apt-get install telnet nmap -y
COPY *.resc .
COPY *.repl .
COPY *.bin .
CMD renode --disable-wxt
