FROM resin/aarch64-alpine:3.7
LABEL io.resin.device-type="jetson-tx1"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*