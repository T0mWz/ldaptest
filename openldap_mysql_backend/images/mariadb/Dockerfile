FROM mariadb:latest

MAINTAINER Tom Wezepoel

COPY sql/ldaptest.sql /tmp/
COPY scripts/init-mariadb.sh /docker-entrypoint-initdb.d/
