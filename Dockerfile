FROM ubuntu:latest
MAINTAINER Anthony Monthe <amonthe@cloudspectator.com>

ENV VERSION 1.0.8

RUN apt update
RUN apt install -y wget build-essential make automake libtool pkg-config \
    libmysqlclient-dev libpq-dev vim-common

WORKDIR /src/
RUN wget https://github.com/akopytov/sysbench/archive/${VERSION}.tar.gz -O /src/sysbench.tar.gz
RUN tar -xzf /src/sysbench.tar.gz
RUN ls /src/sysbench-${VERSION}

WORKDIR /src/sysbench-${VERSION}
RUN ./autogen.sh
RUN ./configure --with-pgsql --without-gcc-arch
RUN make
RUN make install

CMD sysbench
