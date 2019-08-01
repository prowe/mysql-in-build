FROM mysql:5.7 as mysql

FROM php:7.1-apache

WORKDIR /work
ENV MYSQL_MAJOR 5.7
ENV MYSQL_VERSION 5.7.27-1debian9
COPY --from=mysql /etc/apt/trusted.gpg.d/mysql.gpg /etc/apt/trusted.gpg.d/
RUN echo "deb http://repo.mysql.com/apt/debian/ stretch mysql-${MYSQL_MAJOR}" > /etc/apt/sources.list.d/mysql.list

RUN apt-get update
ADD mysql-debSelections.txt ./

RUN debconf-set-selections < mysql-debSelections.txt && \
    apt-get install -y mysql-server="${MYSQL_VERSION}"

RUN chown -R mysql:mysql /var/lib/mysql

RUN docker-php-ext-install mysqli

ADD . ./
