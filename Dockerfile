FROM       hasufell/gentoo-java:latest
MAINTAINER Julian Ospald <hasufell@gentoo.org>

# install tools
RUN chgrp paludisbuild /dev/tty && cave resolve -z sys-process/htop -x

## install confluence
ENV CONFLUENCE_PV 5.8.10

COPY atlassian-confluence-5.8.10.tar.gz /

RUN cd / && \
	gunzip atlassian-confluence-${CONFLUENCE_PV}.tar.gz && \
	tar -xf atlassian-confluence-${CONFLUENCE_PV}.tar && \
	mkdir -p /var/data/confluence/ && \
	echo -e "\nconfluence.home=/var/data/confluence/" \
	>> /atlassian-confluence-${CONFLUENCE_PV}/confluence/WEB-INF/classes/confluence-init.properties

EXPOSE 8090

CMD cd /atlassian-confluence-${CONFLUENCE_PV}/bin && ./start-confluence.sh -fg
