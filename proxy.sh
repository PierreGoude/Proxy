#!/bin/bash
start()
{
clear
if [ -d /etc/squid ]
then
echo "Squid already installed"
     while true; do
     read -p 'Do you really want to continue with this setup? all previous information will be lost! (y/n)?' yn
   case $yn in
    [Yy]* ) echo ""
	        break;;
    [Nn]* ) echo "Exiting Setup"
            sleep 2        
            exit ;;
    * ) echo 'Please answer yes or no.';;
   esac
done
else
sudo apt-get install squid3 -y
fi

sudo apt-get install apache2-utils -y
sudo apt-get install curl -y
clear
echo "          Configurating....          "
sudo touch /etc/squid/squid-passwd
sudo chmod o+r /etc/squid/squid-passwd

echo "          Type in new login user for Squid proxy server          "
read user
htpasswd /etc/squid/squid-passwd $user
echo "          Getting conf file from server          "
wget http://www.webbhatt.com/databas/squid.conf
sudo cat squid.conf > /etc/squid/squid.conf
echo "          Wait for service to start....          "
sudo service squid restart
sleep 1
clear
echo "  Remember to open port 3128 on firewall or portforward "
echo "Printing Public IP... "
curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
sleep 5
exit
}
start
