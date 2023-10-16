#!/bin/sh

# apt update, upgrade, and install pre-req apt-packages
apt -qqy update
apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' full-upgrade
apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install \
        lsb-release \
        wget \
        apt-transport-https \
        ca-certificates \
        gnupg \
        mysql-client-core-8.0

# add proxysql repo && install v2.5.X
wget -qO - 'https://repo.proxysql.com/ProxySQL/proxysql-2.5.x/repo_pub_key' | apt-key add - &&\
echo deb https://repo.proxysql.com/ProxySQL/proxysql-2.5.x/$(lsb_release -sc)/ ./ | tee /etc/apt/sources.list.d/proxysql.list &&\
apt -qqy update

apt -qqy install proxysql=${application_version}
apt-get -qqy clean

# start proxyql w. default config 
service proxysql start
