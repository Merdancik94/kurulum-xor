#!/bin/bash
echo "deb http://cz.archive.ubuntu.com/ubuntu bionic main universe" >> /etc/apt/sources.list && apt update
apt-get update && apt-get build-dep openvpn -y
wget --no-check-cert https://raw.githubusercontent.com/Merdancik94/kurulum-xor/main/openvpn_2.4.8-bionic0_amd64.deb
dpkg -i openvpn_2.4.8-bionic0_amd64.deb
apt install vsftpd -y && sudo adduser mer && sudo service sshd restart && sudo usermod -d /root mer && sudo chmod -R a+rwx /root
distro_check(){
	ID=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
	if [[ $ID == ubuntu ]]; then
		main
	else
		die "ubuntu only"
	fi
}

curl_ip(){
        var='/openvpn-monitor'
        ip=`dig +short myip.opendns.com @resolver1.opendns.com`
        echo ">> Kurulum tamamlandi <<"
        echo "http://"${ip}${var}
}

install_openvpn() {
	echo ">> OpenVPN kurulumu baslatiliyor"
	echo ">> indirme islemi basliyor"
	wget https://raw.githubusercontent.com/Merdancik94/kurulum-xor/main/openvpn-install.sh && bash openvpn-install.sh
	apt-get -y install git curl apache2 libapache2-mod-wsgi python-geoip2 python-ipaddr python-humanize python-bottle python-semantic-version geoip-database-extra geoipupdate
	echo "Apache config ayalari yapiliyor"
	echo "WSGIScriptAlias /openvpn-monitor /var/www/html/openvpn-monitor/openvpn-monitor.py" >> /etc/apache2/conf-available/openvpn-monitor.conf
	echo "<Directory /var/www/html/openvpn-monitor>" >> /etc/apache2/conf-available/openvpn-monitor.conf
	echo "Options FollowSymLinks" >> /etc/apache2/conf-available/openvpn-monitor.conf
	echo "AllowOverride All" >> /etc/apache2/conf-available/openvpn-monitor.conf
	echo "</Directory>" >> /etc/apache2/conf-available/openvpn-monitor.conf
	a2enconf openvpn-monitor
	systemctl restart apache2
	echo "OpenVPN-Monitor kurulumu baslatiliyor"
	cd /var/www/html
	git clone https://github.com/furlongm/openvpn-monitor.git
        echo "management 127.0.0.1 5555" >> /etc/openvpn/server/server.conf
        echo "scramble obfuscate vvROqV7nUZQqsOqi3c/SkLABs2jIRBA+" >> /etc/openvpn/server/server.conf
	echo 'push "route 64.233.160.0 255.255.0.0 net_gateway"
push "route 142.250.150.95 255.255.255.0 net_gateway"
push "route 62.212.252.82 255.255.255.0 net_gateway"
push "route 172.217.0.0 255.255.0.0 net_gateway"
push "route 216.239.32.116 255.255.255.0 net_gateway"
push "route 142.251.142.195 255.255.255.0 net_gateway"
push "route 74.125.0.0 255.255.0.0 net_gateway"
push "route 209.85.223.113 255.255.255.0 net_gateway"
push "route 173.194.220.119 255.255.0.0 net_gateway"
push "route 94.20.252.16 255.255.255.0 net_gateway"
push "route 62.212.254.82 255.255.255.0 net_gateway"
push "route 142.251.1.119 255.255.255.0 net_gateway"
push "route 95.85.126.169 255.255.255.0 net_gateway"
push "route 185.247.119.65 255.255.255.0 net_gateway"
push "route 173.194.222.139 255.255.255.0 net_gateway"
push "route 217.174.234.154 255.255.255.0 net_gateway"
push "route 95.85.124.131 255.255.255.0 net_gateway"
push "route 217.174.238.188 255.255.255.0 net_gateway"
push "route 142.251.37.67 255.255.255.0 net_gateway"
push "route 217.174.227.27 255.255.255.0 net_gateway"
push "route 64.233.164.94 255.255.255.0 net_gateway"
push "route 217.174.238.99 255.255.255.0 net_gateway"
push "route 95.85.108.116 255.255.255.0 net_gateway"
push "route 217.174.227.170 255.255.255.0 net_gateway"
push "route 31.3.2.88 255.255.255.0 net_gateway"
push "route 104.16.151.136 255.255.255.0 net_gateway"
push "route 13.111.18.59 255.255.255.0 net_gateway"
push "route 104.16.150.136 255.255.255.0 net_gateway"
push "route 47.91.95.120 255.255.255.0 net_gateway"
push "route 217.174.232.118 255.255.255.0 net_gateway"
push "route 93.171.223.25 255.255.255.0 net_gateway"
push "route 142.251.37.66 255.255.255.0 net_gateway"
push "route 95.85.126.182 255.255.255.0 net_gateway"
push "route 142.251.142.194 255.255.255.0 net_gateway"
push "route 108.177.14.154 255.255.255.0 net_gateway"
push "route 192.168.1.1 255.255.255.0 net_gateway"
push "route 64.233.165.95 255.255.255.0 net_gateway"
push "route 93.171.220.255 255.255.255.0 net_gateway"
push "route 108.177.14.94 255.255.255.0 net_gateway"
push "route 64.233.165.95 255.255.255.0 net_gateway"
push "route 119.235.114.18 255.255.255.0 net_gateway"
push "route 74.125.205.95 255.255.255.0 net_gateway"
push "route 95.85.126.187 255.255.255.0 net_gateway"
push "route 172.217.22.74 255.255.255.0 net_gateway"
push "route 95.85.125.145 255.255.255.0 net_gateway"
push "route 45.88.198.232 255.255.255.0 net_gateway"
push "route 104.18.225.52 255.255.255.0 net_gateway"
push "route 104.18.226.52 255.255.255.0 net_gateway"
push "route 95.85.120.254 255.255.255.0 net_gateway"
push "route 142.251.142.202 255.255.255.0 net_gateway"
push "route 95.85.125.68 255.255.255.0 net_gateway"
push "route 95.85.125.57 255.255.255.0 net_gateway"
push "route 142.251.37.74 255.255.255.0 net_gateway"
push "route 95.85.126.171 255.255.255.0 net_gateway"' >> /etc/openvpn/server/server.conf
	service openvpn restart
	service openvpn-server@server restart

	echo "AuthType Basic" >> /var/www/html/openvpn-monitor/.htaccess
	echo 'AuthName "Restricted Files"' >> /var/www/html/openvpn-monitor/.htaccess
	echo "AuthUserFile /var/www/.monitor" >> /var/www/html/openvpn-monitor/.htaccess
	echo "Require valid-user" >> /var/www/html/openvpn-monitor/.htaccess
	echo "monitor sayfasina ulasim icin kullanici olusturuluyor"
	read -p 'lutfen bir kullanici adi giriniz: ' uservar
	echo "$uservar kullanicisi olusturuluyor"
	echo "$uservar icin parola giriniz"
	sudo htpasswd -c /var/www/.monitor $uservar
	systemctl restart apache2
}


main() {
	cd
	clear
	install_openvpn
	curl_ip
}

if [[ "$EUID" -ne 0 ]]; then
	echo "root olarak calistirin"
	exit
else
	distro_check
fi
