#!/bin/bash
# ==========================================================
#  zfs-liveview.sh
#  Live-ZFS-Monitor für Proxmox/Debian
#  Zeigt Pool-I/O, ARC-Cache und Logbias/Sync-Status
# ==========================================================

POOL="<POOLNAME>"    # <- ggf. anpassen (z. B. R10NVME oder zpool status - zeigt deine Pools)

clear
echo "🔍  ZFS Live View  -  Ctrl+C zum Beenden"
echo "-------------------------------------------------------------"

while true; do
    echo -e "\n📦  $(date '+%Y-%m-%d %H:%M:%S')"
    echo "-------------------------------------------------------------"
    echo "💽  Pool-Status ($POOL)"
    zpool iostat -v $POOL 2 1 | tail -n +3

    echo
    echo "🧠  ARC-Cache"
    arcstat | head -n 10 2>/dev/null || echo "arcstat nicht gefunden (apt install zfs-auto-snapshot zfsutils-linux)."

    echo
    echo "⚙️  Dataset-Parameter"
    zfs get -H -o property,value sync,logbias,compression,atime,primarycache $POOL 2>/dev/null

    sleep 2
done
