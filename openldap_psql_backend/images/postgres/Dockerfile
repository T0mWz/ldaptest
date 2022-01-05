FROM postgres:12

MAINTAINER Tom Wezepoel

COPY sql/ldaptest.sql /tmp/
COPY scripts/init-postgres.sh /docker-entrypoint-initdb.d/
