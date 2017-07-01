#!/bin/bash
MASTER=$(cat /root/.master.info | cut -d: -f1)
if [[ ! -f /etc/nginx/apps/plexpy.conf ]]; then
  cat > /etc/nginx/apps/plexpy.conf <<RAD
location /plexpy {
  include /etc/nginx/conf.d/proxy.conf;
  proxy_pass        http://127.0.0.1:8181/plexpy;
  auth_basic "What's the password?";
  auth_basic_user_file /etc/htpasswd.d/htpasswd.${MASTER};
}
RAD
fi
sed -i "s/http_root.*/http_root = \"plexpy\"/g" /opt/plexpy/config.ini
sed -i "s/http_host.*/http_host = localhost/g" /opt/plexpy/config.ini