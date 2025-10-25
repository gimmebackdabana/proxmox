#!/bin/bash

echo -e "ZVOL\t\t\tVMID\tSIZE\tUSED\tvolblocksize"
echo "---------------------------------------------------------------"

zfs list -t volume -o name,volsize,used | grep -E "vm-[0-9]+-disk" | while read -r line; do
  ZVOL=$(echo "$line" | awk '{print $1}')
  SIZE=$(echo "$line" | awk '{print $2}')
  USED=$(echo "$line" | awk '{print $3}')
  VMID=$(echo "$ZVOL" | grep -oP 'vm-\K[0-9]+')
  BLOCKSIZE=$(zfs get -H -o value volblocksize "$ZVOL")
  echo -e "$ZVOL\t$VMID\t$SIZE\t$USED\t$BLOCKSIZE"
done
