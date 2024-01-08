FROM alpine:3.16

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY conf/my.conf /etc/mysql/my.cnf
COPY conf/init.sql /tmp/init.sql

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

CMD ["mysqld", "--user=mysql", "--init-file=/tmp/init.sql"]
