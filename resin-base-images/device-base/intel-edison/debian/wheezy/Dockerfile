FROM resin/i386-debian:wheezy
LABEL io.resin.device-type="intel-edison"

RUN apt-get update && apt-get install -y --no-install-recommends \
		less \
		kmod \
		nano \
		net-tools \
		ifupdown \
		iputils-ping \
		i2c-tools \
		usbutils \
	&& rm -rf /var/lib/apt/lists/*

# MRAA
ENV MRAA_COMMIT fbb7d9232067eac3f4508a37a8f7ea0c4fcebacb
ENV MRAA_VERSION 1.9.0
# UPM
ENV UPM_COMMIT cc7fec9ae0228add9011bf1c2cd5e0ca2ba0d4f0
ENV UPM_VERSION 1.6.0

# Install mraa
RUN set -x \
	&& buildDeps=' \
		build-essential \
		git-core \
		libpcre3-dev \
		python-dev \
		swig \
		pkg-config \
		curl \
	' \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& mkdir /cmake \
	&& curl -SL https://cmake.org/files/v3.5/cmake-3.5.2.tar.gz -o cmake.tar.gz \
	&& echo "92d8410d3d981bb881dfff2aed466da55a58d34c7390d50449aa59b32bb5e62a  cmake.tar.gz" | sha256sum -c - \
	&& tar -xzf cmake.tar.gz -C /cmake --strip-components=1 \
	&& cd /cmake \
	&& ./configure \
	&& make -j $(nproc) \
	&& make install \
	&& cd / \
	&& git clone https://github.com/intel-iot-devkit/mraa.git \
	&& cd /mraa \
	&& git checkout $MRAA_COMMIT \
	&& mkdir build && cd build \
	&& cmake .. -DWERROR=NO -DBUILDSWIGNODE=OFF -DBUILDSWIGPYTHON=OFF -DCMAKE_INSTALL_PREFIX:PATH=/usr \
	&& make -j $(nproc) \
	&& make install \
	&& cd / \
	&& git clone https://github.com/intel-iot-devkit/upm.git \
	&& cd /upm \
	&& git checkout $UPM_COMMIT \
	&& mkdir build && cd build \
	&& cmake .. -DWERROR=NO -DBUILDSWIGNODE=OFF -DBUILDSWIGPYTHON=OFF -DCMAKE_INSTALL_PREFIX:PATH=/usr \
	&& make -j $(nproc) \
	&& make install \
	&& cd /cmake \
	&& make uninstall \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& cd / && rm -rf mraa upm cmake

# Update Shared Library Cache
RUN echo "/usr/local/lib/i386-linux-gnu/" >> /etc/ld.so.conf \
	&& ldconfig