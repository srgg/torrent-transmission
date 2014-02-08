#!/opt/bin/bash

if [ -z "$TR_TORRENT_NAME" ]
then
    dropbox_uploader list HTorrents| grep -iE "^ \[F\] .+\.torrent$" | \
    sed "s|^\s\[F\]\s[0-9]*\s*||g" | \
    while read item
    do
        file="HTorrents/$item"
        echo "Start downloading $file"
        dropbox_uploader download "$file" "/mnt/transmission/watch/$item"
        dropbox_uploader delete "$file"
    done
else
    echo "Donwload job done at `date`" > "/tmp/$TR_TORRENT_NAME.txt"
    dropbox_uploader upload "/tmp/$TR_TORRENT_NAME.txt" HTorrents
    rm -f "/tmp/$TR_TORRENT_NAME.txt"
fi
