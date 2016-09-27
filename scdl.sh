#!/bin/sh

artist=$1
url="https://soundcloud.com/$artist"

if [ -f $artist ]
then
    echo "The folder for the artist already exists!"
    exit 1
fi

mkdir $artist &&
cd $artist &&
youtube-dl $url --add-metadata --xattrs --embed-thumbnail;
for file in *
do
    newname=`echo $file|sed 's/-[^(.mp3)]*//'`
    mv $file $newname
done &&
cd ..

if [ $? -ne 0 ]
then
    echo "There was an error, deleting folder"
    rm -r $artist
    exit 1
else
    echo "All the files for the artist have been downloaded!"
mi
