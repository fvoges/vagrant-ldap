#!/bin/bash

# preseed slapd config options
cat > /root/debconf-slapd.conf << 'EOF'
slapd slapd/password1 password admin
slapd slapd/internal/adminpw password admin
slapd slapd/internal/generated_adminpw password admin
slapd slapd/password2 password admin
slapd slapd/unsafe_selfwrite_acl note
slapd slapd/purge_database boolean true
slapd slapd/domain string foo.com
slapd slapd/ppolicy_schema_needs_update select abort installation
slapd slapd/invalid_config boolean true
slapd slapd/move_old_database boolean false
slapd slapd/backend select MDB
slapd shared/organization string HashiCorp
slapd slapd/no_configuration boolean false
slapd slapd/dump_database select when needed
slapd slapd/password_mismatch note
EOF

cat /root/debconf-slapd.conf | debconf-set-selections

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" slapd ldap-utils

ldapadd -x -H ldap://127.0.0.1:389/ -D "cn=admin,dc=foo,dc=com" -w admin -f /vagrant/conf/ldap/ldap_base.ldif
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /vagrant/conf/ldap/load_memberof.ldif
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /vagrant/conf/ldap/load_memberof_overlay.ldif
ldapadd -x -H ldap://127.0.0.1:389/ -D "cn=admin,dc=foo,dc=com" -w admin -f /vagrant/conf/ldap/ldap_users.ldif
ldapadd -x -H ldap://127.0.0.1:389/ -D "cn=admin,dc=foo,dc=com" -w admin -f /vagrant/conf/ldap/ldap_groups.ldif
