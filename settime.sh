#!/bin/bash
#APP Servers
users=("steve" "banner")
passwd=("Am3ric@" "BigGr33n")
server=("172.16.238.11" "172.16.238.12")

#set time zone
echo "Set time zone to America/New_York"
function settimezone() {
  for i in "${server[@]}" 
            do 
            sshpass -p "${passwd[$i]}" ssh -o StrictHostKeyChecking=no ${users[$i]}@${server[$i]} "sudo timedatectl set-timezone America/New_York"
            done
                                   
            }
settimezone



   
