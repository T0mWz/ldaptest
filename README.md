LDAP Test with database backend
=========

This is my attempt to get SLAPD working with a PostgreSQL or a MariaDB backend in a Docker environment.

In the specific folder you can just run;
```bash
docker-compose build
docker-compose up
```

### phpLDAPadmin
A phpLDAPadmin environment will startup on localhost port 8080; http://127.0.0.1:8080
 - Login DN; `cn=root,dc=example,dc=com`
 - Login pass; `secret`

### Credits

Thanks to [Arno Geurts](https://github.com/arnogeurts) and [Pierangelo Masarati](https://github.com/openldap/openldap/tree/master/servers/slapd/back-sql/rdbms_depend)



