FROM resin/armhf-alpine:3.6

LABEL io.resin.device-type="zc702-zynq7"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \		
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*
