#! /bin/bash

BASE=/home/gray/Desktop/gray.clhn.co/_rawdog

for SUBDIR in research working announcements news tech sports pictures music
do 
    rawdog -uw -d $BASE/$SUBDIR
    mv $BASE/$SUBDIR/output.html $BASE/rivers/$SUBDIR.html
done

rsync -avz --delete $BASE/rivers gcalhoun_gfcal@ssh.phx.nearlyfreespeech.net: