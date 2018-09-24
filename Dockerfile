FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y curl tar perl libnet-ssleay-perl expect tzdata && \
    mkdir /opt/webmin && curl -sSL https://prdownloads.sourceforge.net/webadmin/webmin-1.890-minimal.tar.gz | tar xz -C /opt/webmin --strip-components=1 && \
    mkdir -p /var/webmin/ && \
    ln -s /dev/stdout /var/webmin/miniserv.log

COPY /scripts/entrypoint.sh /
COPY /scripts/config.exp /

RUN chmod +x entrypoint.sh

VOLUME /etc/webmin/

EXPOSE 10000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/perl","/opt/webmin/miniserv.pl","/etc/webmin/miniserv.conf"]