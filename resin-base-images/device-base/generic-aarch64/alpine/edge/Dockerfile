FROM resin/aarch64-alpine:edge
LABEL io.resin.device-type="generic-aarch64"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*