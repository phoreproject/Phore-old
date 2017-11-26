# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.22

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

WORKDIR /phore

RUN apt-get install software-properties-common
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update && apt-get install -y \
    build-essential \
    libtool \
    autotools-dev \
    pkg-config \
    libssl-dev \
    libboost-all-dev \
    libevent-dev \
    libminiupnpc-dev \
    autoconf \
    automake \
    libdb4.8-dev \
    libdb4.8++-dev \
    uuid-dev \
    libzmq3-dev \
    libqt5gui5 \
    libqt5core5a \
    libqt5dbus5 \
    qttools5-dev \
    qttools5-dev-tools \
    libprotobuf-dev \
    protobuf-compiler \
    libqrencode-dev
ADD . /phore
RUN chmod +x autogen.sh src/leveldb/build_detect_platform share/genbuild.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*