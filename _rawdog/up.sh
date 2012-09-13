#! /bin/bash

BASE=/home/gray/Desktop/gray.clhn.co/_rawdog

## Public rivers
for SUBDIR in research working announcements
do 
    rawdog -uw -d $BASE/$SUBDIR
    mv $BASE/$SUBDIR/output.html $BASE/rivers/$SUBDIR.html
done
## Private rivers (at least for now)
for SUBDIR in news tech sports pictures politics music
do 
    rawdog -uw -d $BASE/$SUBDIR
    mv $BASE/$SUBDIR/output.html $BASE/private/$SUBDIR.html
done

rsync -avz --delete $BASE/rivers $BASE/private gcalhoun_gfcal@ssh.phx.nearlyfreespeech.net:
