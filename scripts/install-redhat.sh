# This scripts is copied from http://toolbelt.treasuredata.com/sh/install-redhat.sh

echo "This script requires superuser access to install rpm packages."

sh <<SCRIPT

  # add GPG key
  rpm --import http://packages.treasuredata.com/GPG-KEY-td-agent

  # add treasure data repository to yum
  cat >/etc/yum.repos.d/td.repo <<'EOF';
[treasuredata]
name=TreasureData
baseurl=http://td-agent-repository.s3-website-us-east-1.amazonaws.com/redhat/6/\$basearch
gpgcheck=1
gpgkey=http://packages.treasure-data.com/redhat/RPM-GPG-KEY-td-agent
EOF

  # update your sources
  yum -y update

  # install the toolbelt
  yum -y install td-agent2

SCRIPT
