FROM resin/armv7hf-fedora:26
LABEL io.resin.device-type="odroid-xu4"

RUN dnf install -y \
		less \
		nano \
		net-tools \
		usbutils \
		gnupg \
		i2c-tools \
	&& dnf clean all