# FTP
> The evolution of the Internet has made it possible to see the appearance of several technologies such as that of
FTP. We will therefore see how to install it and how to secure it with `TLS SSL`.

## To install `proftpd`
* Open your command prompt. 
* Then enter the following command :
```
sudo apt-get install proftpd-*
```
This command line permits you to install all packages of `proftpd`.
* Then enter the following command to update your packages and software :
```
sudo apt-get update && sudo apt-get upgrade
```

## To configure `proftpd`
* Edit the `proftpd` configuration file : `/etc/proftpd/proftpd.conf` and don't forget to make a backup.
* Find and uncomment the following lines (removing the # at the beginning of each line) to allow "standard" anonymous access :
```
#A basic anonymous configuration, no upload directories.

 <Anonymous ~ftp>
   User                         ftp
   Group                        nogroup
   #We want clients to be able to login with "anonymous" as well as "ftp"
   UserAlias                    anonymous ftp
   #Cosmetic changes, all files belongs to ftp user
   DirFakeUser  on ftp
   DirFakeGroup on ftp
 
   RequireValidShell            off
 
   #Limit the maximum number of anonymous logins
   MaxClients                   10
 
   #We want 'welcome.msg' displayed at login, and '.message' displayed
   #in each newly chdired directory.
   DisplayLogin                 welcome.msg
   DisplayFirstChdir            .message
 
   #Limit WRITE everywhere in the anonymous chroot
   <Directory *>
     <Limit WRITE>
       DenyAll
     </Limit>
   </Directory>
 </Anonymous>
```
* Then enter the following command once the configuration has been modified in order to restart the server modifications :
```
sudo service proftpd restart
```
## To configure `TLS SSL`
* Open your command prompt. 
* Then enter the following command :
```
cd /etc/proftpd/ && sudo mkdir ssl && cd ssl/
```
* Then enter the following command to generate the ssl certificate and key :
```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:4096 -out proftpd-rsa.pem -keyout proftpd-key.pem
```
* Then enter the following command to protect the key :
```
sudo chmod 0600 proftpd-key.pem
```
* Edit the `tls` configuration file : `/etc/proftpd/tls.conf` and don't forget to make a backup.
* Find and uncomment the following lines (removing the # at the beginning of each line) :
```
TLSEngine on
TLSLog /var/log/proftpd/tls.log
TLSProtocol SSLv23

TLSRSACertificateFile /etc/proftpd/ssl/proftpd-rsa.pem
TLSRSACertificateKeyFile /etc/proftpd/ssl/proftpd-key.pem

TLSOptions NoSessionReuseRequired
TLSVerifyClient off
TLSRequired on
```
* In some cases, the connection is not made and returns `500 AUTH not understood`, you can solve the problem by uncommenting the following line at the top of the file `/etc/proftpd/proftpd.conf` :
```
Include /etc/proftpd/modules.conf
```
* Then edit the `modules` configuration file : `/etc/proftpd/modules.conf`.
* Find and uncomment the following line (removing the # at the beginning of line) :
```
LoadModule mod_tls.c
```
* Then enter the following command once the configuration has been modified in order to restart the server modifications :
```
sudo service proftpd restart
```

#### Now you have working FTP secured with TLS SSL.
