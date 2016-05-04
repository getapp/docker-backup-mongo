FROM quay.io/getapp/docker-backup

MAINTAINER Boris Mikhaylov

# install mongodump
ENV MONGO_VERSION 3.2.4
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
 && echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

RUN apt-get update \
    && apt-get install -y mongodb-org-tools=$MONGO_VERSION \
    && apt-get autoremove -y -qq \
    && apt-get clean -qq
