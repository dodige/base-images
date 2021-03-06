FROM i386/debian:wheezy-slim
LABEL io.resin.architecture="i386-nlp"

RUN apt-get update && apt-get install -y --no-install-recommends \
  sudo \
  ca-certificates \
  findutils \
  gnupg \
  dirmngr \
  inetutils-ping \
  netbase \
  curl \
  udev \
  $( \
      if apt-cache show 'iproute' 2>/dev/null | grep -q '^Version:'; then \
        echo 'iproute'; \
      else \
        echo 'iproute2'; \
      fi \
  ) \
  && rm -rf /var/lib/apt/lists/*

RUN set -x \
  && buildDeps='git-core autoconf libtool automake build-essential debhelper fakeroot cmake dpkg-dev devscripts' \
  && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
  && git clone https://github.com/mdr78/libx1000.git \
  && cd libx1000 \
  && git checkout 1bfb62bb62e0ebe0e42817edd9702d91d232dbee \
  && cd libx1000-0.0.0 \
  && libtoolize --force \
  && aclocal \
  && autoheader \
  && automake --force-missing --add-missing \
  && autoconf \
  && ./autogen.sh \
  && ./configure \
  && make && make install \
  && apt-get purge -y --auto-remove $buildDeps \
  && cd / && rm -rf /libx1000

RUN curl -SLO "http://resin-packages.s3.amazonaws.com/resin-xbuild/v1.0.0/resin-xbuild1.0.0.tar.gz" \
  && echo "1eb099bc3176ed078aa93bd5852dbab9219738d16434c87fc9af499368423437  resin-xbuild1.0.0.tar.gz" | sha256sum -c - \
  && tar -xzf "resin-xbuild1.0.0.tar.gz" \
  && rm "resin-xbuild1.0.0.tar.gz" \
  && chmod +x resin-xbuild \
  && mv resin-xbuild /usr/bin \
  && ln -s resin-xbuild /usr/bin/cross-build-start \
  && ln -s resin-xbuild /usr/bin/cross-build-end

ENV TINI_VERSION 0.14.0
RUN curl -SLO "http://resin-packages.s3.amazonaws.com/tini/v0.14.0/tini0.14.0.linux-i386.tar.gz" \
  && echo "9f4a0b536efdcbe92bc81c6e68dbf8dc1c5739e58f4e7e3a91f07094655149e8  tini0.14.0.linux-i386.tar.gz" | sha256sum -c - \
  && tar -xzf "tini0.14.0.linux-i386.tar.gz" \
  && rm "tini0.14.0.linux-i386.tar.gz" \
  && chmod +x tini \
  && mv tini /sbin/tini

ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
# For backward compatibility, udev is enabled by default
ENV UDEV on

# 01_nodoc
RUN echo 'path-exclude /usr/share/doc/*\n\
# we need to keep copyright files for legal reasons\n\
path-include /usr/share/doc/*/copyright\n\
path-exclude /usr/share/man/*\n\
path-exclude /usr/share/groff/*\n\
path-exclude /usr/share/info/*\n\
path-exclude /usr/share/lintian/*\n\
path-exclude /usr/share/linda/*\n\
path-exclude /usr/share/locale/*\n\
path-include /usr/share/locale/en*' > /etc/dpkg/dpkg.cfg.d/01_nodoc

# 01_buildconfig
RUN echo 'APT::Get::Assume-Yes "true";\n\
APT::Install-Recommends "0";\n\
APT::Install-Suggests "0";\n\
quiet "true";' > /etc/apt/apt.conf.d/01_buildconfig

RUN mkdir -p /usr/share/man/man1

ONBUILD RUN echo 'WARNING: Systemd is not available on this base image! \n\Systemd was included in Debian wheezy as a technology preview. Therefore, we do not install systemd on wheezy images and INITSYSTEM will not work.'

COPY entry.sh /usr/bin/entry.sh

ENTRYPOINT ["/usr/bin/entry.sh"]