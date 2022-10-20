#!/bin/bash

echo "#############################"
echo "#    Root user required     #"
echo "#############################"

echo "Option '1' Install and configure ProFTPd"
echo "Option '2' Uninstall ProFTPd"
echo "Option '3' Quit script"

echo -n "Choose an option : "
read option

case $option in
    "1")
        apt-get -y install proftpd-* && apt-get -y install git && apt-get -y update && apt-get -y upgrade
        mv /etc/proftpd/proftpd.conf /etc/proftpd/proftpd_backup.conf
        mv /etc/proftpd/tls.conf /etc/proftpd/tls_backup.conf
        mv /etc/proftpd/modules.conf /etc/proftpd/modules_backup.conf
        
        git clone https://github.com/yoann-fermaud/FTP.git
        mv FTP/ftp-config/ftp-config-proftpd.conf /etc/proftpd/proftpd.conf
        mv FTP/ftp-config/ftp-config-tls.conf /etc/proftpd/tls.conf
        mv FTP/ftp-config/ftp-config-modules.conf /etc/proftpd/modules.conf
        
        #If you want to remove the git clone after the installation
        #cd && rm -r FTP/
        
        mkdir -p /etc/proftpd/ssl
	echo -ne "\n\n\n\n\n\n\n" | openssl req -x509 -nodes -days 365 -newkey rsa:4096 -out /etc/proftpd/ssl/proftpd-rsa.pem -keyout /etc/proftpd/ssl/proftpd-key.pem
        chmod 0600 /etc/proftpd/ssl/proftpd-key.pem
        
        service proftpd restart
        echo "Configuration done !"
    ;;
    
    "2")
        apt-get -y remove proftpd-* git
    	apt-get -y purge proftpd-* git
    	
    	#If you want to remove the git clone
        #cd && rm -r FTP/
        
    	echo "FTP has successfully been unistall."
    ;;
    
    "3")
        exit
    ;;
    
    *)
        echo "Error : available option are '1', '2' or '3'"
    ;;
esac
