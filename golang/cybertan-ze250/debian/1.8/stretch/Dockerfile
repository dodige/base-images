FROM resin/cybertan-ze250-buildpack-deps:stretch

ENV GO_VERSION 1.8.7

RUN mkdir -p /usr/local/go \
	&& curl -SLO "http://resin-packages.s3.amazonaws.com/golang/v$GO_VERSION/go$GO_VERSION.linux-i386.tar.gz" \
	&& echo "441af4d7c709781d930de7590944b57fa30b61a41c23c54f925871086289bf4f  go1.8.7.linux-i386.tar.gz" | sha256sum -c - \
	&& tar -xzf "go$GO_VERSION.linux-i386.tar.gz" -C /usr/local/go --strip-components=1 \
	&& rm -f go$GO_VERSION.linux-i386.tar.gz

ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/

CMD ["echo","'No CMD command was set in Dockerfile! Details about CMD command could be found in Dockerfile Guide section in our Docs. Here's the link: http://docs.resin.io/deployment/dockerfile"]
