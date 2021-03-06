#!/opt/bin/bash

PATH=/opt/sbin:/opt/bin:/opt/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

dir=HTorrents

if [ -z "$TR_TORRENT_NAME" ]
then
    dropbox_uploader list $dir| grep -iE "^ \[F\] .+\.torrent$" | \
    sed "s|^\s\[F\]\s[0-9]*\s*||g" | \
    while read item
    do
        file="$dir/$item"
        echo "Start downloading $file"
        dropbox_uploader download "$file" "/mnt/transmission/watch/$item"
        chmod 644 "/mnt/transmission/watch/$item"
        chown nobody:admin "/mnt/transmission/watch/$item"
        dropbox_uploader delete "$file"
        logger "File '$item' has been donloaded"
    done
else
    echo "Donwload job done at `date`" > "/tmp/$TR_TORRENT_NAME.txt"
    dropbox_uploader upload "/tmp/$TR_TORRENT_NAME.txt" $dir
    rm -f "/tmp/$TR_TORRENT_NAME.txt"
fi
