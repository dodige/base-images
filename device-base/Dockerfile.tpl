FROM #{FROM}

LABEL io.resin.device-type="#{DEV_TYPE}"

RUN apt-get update && apt-get install -y --no-install-recommends \
		less \
		module-init-tools \
		nano \
		net-tools \
		ifupdown \	
		iputils-ping \	
		i2c-tools \
		usbutils \	
	&& rm -rf /var/lib/apt/lists/*
