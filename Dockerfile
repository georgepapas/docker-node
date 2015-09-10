FROM node:0.12.7

# verify gpg and sha256: http://nodejs.org/dist/v0.10.30/SHASUMS256.txt.asc
# gpg: aka "Timothy J Fontaine (Work) <tj.fontaine@joyent.com>"
# gpg: aka "Julien Gilli <jgilli@fastmail.fm>"
# RUN set -ex \
# 	&& for key in \
# 		7937DFD2AB06298B2293C3187D33FF9D0246406D \
# 		114F43EE0176B71C7BC219DD50A3051F888C628D \
# 	; do \
# 		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
# 	done

ENV NODE_VERSION 0.12.7

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz" \
	&& curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \	
	&& mkdir -p /usr/node \
	&& tar -xzf "node-v$NODE_VERSION.tar.gz" -C /usr/node --strip-components=1 	

CMD [ "node" ]
