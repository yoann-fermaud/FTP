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
        apt -y install proftpd-* && apt-get -y update && apt-get -y upgrade
        mv /etc/proftpd/proftpd.conf /etc/proftpd/proftpd_backup.conf
        mv /etc/proftpd/tls.conf /etc/proftpd/tls_backup.conf
        mv /etc/proftpd/modules.conf /etc/proftpd/modules_backup.conf
        
        git clone https://github.com/yoann-fermaud/ftp-config.git
        mv ftp-config/ftp-config-proftpd.conf /etc/proftpd/proftpd.conf
        mv ftp-config/ftp-config-tls.conf /etc/proftpd/tls.conf
        mv ftp-config/ftp-config-modules.conf /etc/proftpd/modules.conf
        rm -r ftp-config/
        
        mkdir -p /etc/proftpd/ssl
	openssl req -x509 -nodes -days 365 -newkey rsa:4096 -out /etc/proftpd/ssl/proftpd-rsa.pem -keyout /etc/proftpd/ssl/proftpd-key.pem
	#-subj "/C=''/ST=''/L=''/O=''/OU=''/CN=''" 
        chmod 0600 /etc/proftpd/ssl/proftpd-key.pem
        
        service proftpd restart
        echo "Configuration done !"
    ;;
    
    "2")
        apt-get -y remove proftpd-*
    	apt-get -y purge proftpd-*
    	echo "FTP has successfully been unistall."
    ;;
    
    "3")
        exit
    ;;
    
    *)
        echo "Error : available option are '1', '2' or '3'"
    ;;
esac
