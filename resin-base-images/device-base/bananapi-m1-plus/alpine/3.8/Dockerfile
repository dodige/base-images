FROM resin/armv7hf-alpine:3.8
LABEL io.resin.device-type="bananapi-m1-plus"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*