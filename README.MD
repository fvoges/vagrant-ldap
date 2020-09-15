# OpenLDAP Vagrant box

## Usage

1. clone the repo
2. vagrant up

The LDAP admin credentials are:

- user: `cn=admin,dc=foo,dc=com`
- password: `admin`

The users are under `ou=people,dc=foo,dc=com`, and the groups under `ou=groups,dc=foo,dc=com`

### Users

The password for all users is `password`

- beast
- captainamerica
- cyclops
- hulk
- thor
- vault
- wolverine

### Groups

- avengers
- vaultadmin
- xmen

### Testing

```shell
ldapsearch -x -LLL -H ldap:/// -b uid=beast,ou=people,dc=foo,dc=com dn memberof
```
