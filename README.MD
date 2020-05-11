# OpenLDAP Vagrant box

## Usage

1. clone the repo
2. vagrant up
3. vagrant ssh
4. sudo dpkg-reconfigure slapd (set your domain and admin passwd)
5. ldapadd -x -H ldap://127.0.0.1:389/ -D "cn=admin,dc=foo,dc=com" -W -f ldap_base.ldif
6. sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f load_memberof.ldif
7. sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f load_memberof_overlay.ldif
8. ldapadd -x -H ldap://127.0.0.1:389/ -D "cn=admin,dc=foo,dc=com" -W -f ldap_users.ldif

### Testing
```
ldapsearch -x -LLL -H ldap:/// -b uid=beast,ou=people,dc=foo,dc=com dn memberof
```
