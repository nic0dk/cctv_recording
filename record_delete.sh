#!/bin/sh
# record_delete.sh
# Record ip cam in segments

LQDIR="/mnt/cctv/archive" # Do not include tail '/' (bash 'find' command will not execute property)
HQDIR="/mnt/cctv/video" # Do not include tail '/'
#LOCALSTOREF="/LocalCAM" # Do not include tail '/'

## Delete LQ files older than 30 days
find $LQDIR -maxdepth 1 -type f -mtime 30 -exec rm {} \;
## Delete HQ files older than 10 days
find $HQDIR -maxdepth 1 -type f -mtime 10 -exec rm {} \;
