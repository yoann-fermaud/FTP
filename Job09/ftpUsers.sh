#!/bin/bash

MY_FILE="$1"
groupadd ftpGroup

#New users
export IFS=","
cat "$MY_FILE" | while read a b c d e || [ -n "$e" ];
do
    #String of tab characters
    string="$a : $b : $c : $d : $e"
    
    #Corrected username with no space
    userName="$b"_"$c"
    cleanUserName="${userName// /}"
    
    #Password doubled because too short
    userPasswd="$d$d"

    if [ "$a" != "Id" ]; then
        echo -ne "$userPasswd\n$userPasswd" | adduser "$cleanUserName" && echo -ne "\n"
        adduser "$cleanUserName" ftpGroup
        
        if [[ "$e" = *"Admin"* ]]; then
	    adduser "$cleanUserName" sudo
	fi
    else
        echo "$string"
    fi
done
