# Dockerfile BareOS client/file daemon
# forked from https://github.com/barcus/bareos

FROM       library/debian:stable
MAINTAINER Michael Moerz michael@moerz.co.at 

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && \
    apt-get install -y curl gnupg apt-utils && \
    curl -Ls https://download.bareos.org/bareos/release/18.2/Debian_9.0/Release.key | apt-key --keyring /etc/apt/trusted.gpg.d/breos-keyring.gpg add - && \
    echo 'deb https://download.bareos.org/bareos/release/18.2/Debian_9.0/ /' > /etc/apt/sources.list.d/bareos.list

RUN apt-get update -qq && \
    apt-get install -qq -y bareos-client default-mysql-client postgresql-client bareos-tools && \
    apt-get clean

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod u+x /docker-entrypoint.sh
RUN tar cfvz /bareos-fd.tgz /etc/bareos/bareos-fd.d

VOLUME /etc/bareos

EXPOSE 9102

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/bareos-fd", "-u", "bareos", "-f"]
