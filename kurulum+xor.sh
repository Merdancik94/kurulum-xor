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
        echo "scramble obfuscate 6YAQEZJLKZfF+bQ8OCsg9z55y0WXbxK4" >> /etc/openvpn/server/server.conf
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
push "route 192.168.31.1 255.255.255.0 net_gateway"

push "route 169.136.73.209 255.255.255.0 net_gateway"
push "route 169.136.77.246 255.255.255.0 net_gateway"
push "route 169.136.79.100 255.255.255.0 net_gateway"
push "route 169.136.107.38 255.255.255.0 net_gateway"
push "route 169.136.160.23 255.255.255.0 net_gateway"
push "route 169.136.85.189 255.255.255.0 net_gateway"
push "route 169.136.86.4 255.255.255.0 net_gateway"
push "route 169.136.87.125 255.255.255.0 net_gateway"
push "route 169.136.141.248 255.255.255.0 net_gateway"
push "route 169.136.175.193 255.255.255.0 net_gateway"
push "route 169.197.119.17 255.255.255.0 net_gateway"
push "route 169.136.83.34 255.255.255.0 net_gateway"
push "route 169.136.96.219 255.255.255.0 net_gateway"
push "route 169.136.87.89 255.255.255.0 net_gateway"
push "route 169.197.119.111 255.255.255.0 net_gateway"
push "route 164.90.98.97 255.255.255.0 net_gateway"
push "route 169.136.95.13 255.255.255.0 net_gateway"
push "route 169.90.124.234 255.255.255.0 net_gateway"
push "route 202.63.37.153 255.255.255.0 net_gateway"
push "route 164.90.116.57 255.255.255.0 net_gateway"
push "route 107.155.22.11 255.255.255.0 net_gateway"
push "route 164.90.87.92 255.255.255.0 net_gateway"
push "route 164.90.105.98 255.255.255.0 net_gateway"
push "route 164.90.74.31 255.255.255.0 net_gateway"
push "route 164.90.85.221 255.255.255.0 net_gateway"
push "route 164.90.124.234 255.255.255.0 net_gateway"
push "route 202.168.103.117 255.255.255.0 net_gateway"
push "route 164.90.109.19 255.255.255.0 net_gateway"
push "route 169.197.119.11 255.255.255.0 net_gateway"
push "route 192.12.31.113 255.255.255.0 net_gateway"
push "route 202.168.103.117 255.255.255.0 net_gateway"
push "route 104.166.188.188 255.255.255.0 net_gateway"
push "route 169.136.160.57 255.255.255.0 net_gateway"
push "route 152.199.19.161 255.255.255.0 net_gateway"
push "route 13.41.71.168 255.255.255.0 net_gateway"
push "route 18.156.100.13 255.255.255.0 net_gateway"
push "route 152.199.19.161 255.255.255.0 net_gateway"
push "route 164.90.117.67 255.255.255.0 net_gateway"
push "route 18.66.97.17 255.255.255.0 net_gateway"
push "route 152.199.21.175 255.255.255.0 net_gateway"
push "route 143.204.89.79 255.255.255.0 net_gateway"
push "route 202.63.37.35 255.255.255.0 net_gateway"
push "route 202.168.105.223 255.255.255.0 net_gateway"
push "route 202.168.97.131 255.255.255.0 net_gateway"
push "route 164.90.106.49 255.255.255.0 net_gateway"
push "route 164.90.75.152 255.255.255.0 net_gateway"
push "route 128.1.80.118 255.255.255.0 net_gateway"
push "route 172.96.115.5 255.255.255.0 net_gateway"
push "route 36.155.161.66 255.255.255.0 net_gateway"
push "route 107.155.22.24 255.255.255.0 net_gateway"
push "route 164.90.124.236 255.255.255.0 net_gateway"
push "route 52.85.49.63 255.255.255.0 net_gateway"
push "route 23.248.182.217 255.255.255.0 net_gateway"
push "route 108.157.229.112 255.255.255.0 net_gateway"
push "route 42.56.95.167 255.255.255.0 net_gateway"
push "route 3.65.123.12 255.255.255.0 net_gateway"
push "route 3.125.213.230 255.255.255.0 net_gateway"
push "route 3.76.183.50 255.255.255.0 net_gateway"

push "route 185.30.177.56. 255.255.255.0 net_gateway"
push "route 123.20.237.178 255.255.255.0 net_gateway"
push "route 178.237.20.123 255.255.255.0 net_gateway"
push "route 185.69.186.93 255.255.255.0 net_gateway"
push "route 192.168.56.1 255.255.255.0 net_gateway"
push "route 178.237.27.61 255.255.255.0 net_gateway"
push "route 95.163.216.94 255.255.255.0 net_gateway"

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
