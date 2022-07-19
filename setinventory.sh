#!/bin/bash
group="web"
name="$1"
sh-keygen

echo "[$group]" >> /home/ansible/inventory
for i in $(seq 1 $2); do
  echo "$name$i" >> /home/ansible/inventory
  ssh-copy-id $name$i    
done

