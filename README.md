# FTP

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
