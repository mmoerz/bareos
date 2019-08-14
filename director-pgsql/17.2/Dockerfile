# BareOS director Dockerfile

FROM       library/debian:stable
MAINTAINER Michael Moerz michael@moerz.co.at 

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && \
    apt-get install -y curl gnupg apt-utils && \
    curl -Ls https://download.bareos.org/bareos/release/17.2/Debian_9.0/Release.key | apt-key --keyring /etc/apt/trusted.gpg.d/breos-keyring.gpg add - && \
    echo 'deb http://download.bareos.org/bareos/release/17.2/Debian_9.0/ /' > /etc/apt/sources.list.d/bareos.list

RUN echo 'bareos-database-common bareos-database-common/dbconfig-install boolean false' | debconf-set-selections && \
    echo 'bareos-database-common bareos-database-common/install-error select ignore' | debconf-set-selections && \
    echo 'bareos-database-common bareos-database-common/database-type select psql' | debconf-set-selections && \
    echo 'bareos-database-common bareos-database-common/missing-db-package-error select ignore' | debconf-set-selections && \
    echo 'postfix postfix/main_mailer_type select No configuration' | debconf-set-selections && \
    apt-get update -qq && \
    apt-get install -qq -y bareos postgresql-client && \
    apt-get clean

COPY docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh
RUN tar cfvz /bareos-dir.tgz /etc/bareos

EXPOSE 9101

VOLUME /etc/bareos

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/bareos-dir", "-u", "bareos", "-f"]
