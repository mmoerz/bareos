# Dockerfile BareOS storage daemon
FROM       library/debian:stable
MAINTAINER Michael Moerz <michael@moerz.co.at>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && \
    apt-get install -y curl gnupg apt-utils && \
    curl -Ls https://download.bareos.org/bareos/release/17.2/Debian_9.0/Release.key | apt-key --keyring /etc/apt/trusted.gpg.d/breos-keyring.gpg add - && \
    echo 'deb http://download.bareos.org/bareos/release/17.2/Debian_9.0/ /' > /etc/apt/sources.list.d/bareos.list

RUN apt-get update -qq && \
    apt-get install -qq -y bareos-storage && \
    apt-get clean

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod u+x /docker-entrypoint.sh
RUN tar cfvz /bareos-sd.tgz /etc/bareos/bareos-sd.d

EXPOSE 9103

VOLUME /etc/bareos
VOLUME /var/lib/bareos/storage

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/bareos-sd", "-u", "bareos", "-f"]
