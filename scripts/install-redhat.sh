# This scripts is copied from http://toolbelt.treasuredata.com/sh/install-redhat.sh

echo "This script requires superuser access to install rpm packages."

sh <<SCRIPT

  # add GPG key
  rpm --import http://packages.treasuredata.com/GPG-KEY-td-agent

  # add treasure data repository to yum
  cat >/etc/yum.repos.d/td.repo <<'EOF';
[treasuredata]
name=TreasureData
baseurl=http://packages.treasuredata.com/redhat/\$basearch
gpgcheck=1
gpgkey=http://packages.treasuredata.com/GPG-KEY-td-agent
EOF

  # update your sources
  yes n | yum update

  # install the toolbelt
  yes | yum install -y td-agent

SCRIPT
