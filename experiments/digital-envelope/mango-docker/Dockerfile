ARG base
FROM mageia:7
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"

COPY install-pkgs.sh proxy.sh /tmp/
RUN source /tmp/install-pkgs.sh ; rm /tmp/*.sh
