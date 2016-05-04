FROM quay.io/getapp/docker-backup

MAINTAINER Boris Mikhaylov

# add mongodb repository
RUN \
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \
    echo "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen" | tee /etc/apt/sources.list.d/mongodb.list

RUN apt-get update \
    && apt-get install -y mongodb-org-tools \
    && apt-get autoremove -y -qq \
    && apt-get clean -qq
