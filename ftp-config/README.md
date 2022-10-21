# ftp-config
> The `ftp-config` files contain all necessary changes and will replace your base files.  
> The basic `proftpd` files will be placed in a backup file.  
> `proftpd` configuration file to import from a script for a given configuration.
## `ftp-config-proftpd.conf` file
`ftp-config-proftpd.conf` is configured to enable `TLS SSL` and anonymous login. In addition, only the user's personal files are accessible.
```
#Use this to jail all users in their homes
DefaultRoot    ~

#This is used for FTPS connections
Include /etc/proftpd/tls.conf

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

## `ftp-config-tls.conf` file
`ftp-config-tls.conf` is configured to enable `TLS SSL`.
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

## `ftp-config-modules.conf` file
`ftp-config-modules.conf` is configured to enable `TLS SSL`.
```
#Install proftpd-mod-crypto to use this module for TLS/SSL support.
LoadModule mod_tls.c
```
