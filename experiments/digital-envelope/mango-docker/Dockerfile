ARG base
FROM mageia:7
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"

COPY install-rpm.sh proxy.sh /tmp/
RUN source /tmp/install-rpm.sh ; rm /tmp/*.sh
COPY install-git.sh proxy.sh /tmp/
RUN source /tmp/install-git.sh ; rm /tmp/*.sh
COPY install-pkgs.sh proxy.sh startup.sh CustomGenesis.json \
     test-system.sh \
     graphql-server.mjs /tmp/
RUN source /tmp/install-pkgs.sh ; rm /tmp/*.sh