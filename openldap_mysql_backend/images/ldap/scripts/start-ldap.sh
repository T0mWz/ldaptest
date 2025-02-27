#!/bin/bash

sed -i "s^%HOST%^$LDAPTEST_POSTGRES_PORT_5432_TCP_ADDR^g" /etc/odbc.ini
sed -i "s^%PORT%^$LDAPTEST_POSTGRES_PORT_5432_TCP_PORT^g" /etc/odbc.ini
sed -i "s^%PASSWORD%^$LDAPTEST_POSTGRES_ENV_POSTGRES_PASSWORD^g" /etc/odbc.ini
sed -i "s^%USERNAME%^$LDAPTEST_POSTGRES_ENV_POSTGRES_USER^g" /etc/odbc.ini

while :
    do
	mysqladmin ping -h mariadb -u ldaptest --password=ldaptest | grep alive -q
        result=$?
        if [[ $result -ne 0 ]]; then
            echo "MariaDB is not yet ready to accept connections..."
        else
            echo "MariaDB is ready to accept connections!"
            break
        fi
        sleep 1
    done

/usr/sbin/slapd -d -1 -f /etc/ldap/slapd.conf
