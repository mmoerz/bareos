# BareOS Web-ui Dockerfile
FROM       library/debian:stable
MAINTAINER Michael Moerz <michael@moerz.co.at>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && \
    apt-get install -y curl gnupg apt-utils && \
    curl -Ls https://download.bareos.org/bareos/release/17.2/Debian_9.0/Release.key | apt-key --keyring /etc/apt/trusted.gpg.d/breos-keyring.gpg add - && \
    echo 'deb http://download.bareos.org/bareos/release/17.2/Debian_9.0/ /' > /etc/apt/sources.list.d/bareos.list 

RUN apt-get update -qq && \
    apt-get install -qq -y bareos-webui && \
    apt-get clean && \
    echo ServerName ${HOSTNAME} >> /etc/apache2/conf-available/httpd.conf && \
    a2enconf httpd.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod u+x /docker-entrypoint.sh
RUN tar cfvz /bareos-webui.tgz /etc/bareos-webui

EXPOSE 80

VOLUME /etc/bareos-webui

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
