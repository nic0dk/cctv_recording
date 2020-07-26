#!/bin/sh
# record_lq.sh
# Record ip cam in segments

STARTTIME=$(/bin/date +"%m.%d.%Y")_"["$(/bin/date +"%H")h_$(/bin/date +"%M")m_$(/bin/date +"%S")s"]"

## IP Camera Names ##
CAM1D=indkorsel_$STARTTIME
CAM2D=terrasse_$STARTTIME
CAM3D=hoveddor_$STARTTIME
CAM4D=terrasseSV_$STARTTIME
CAM5D=terrasseNV_$STARTTIME

## Network and Local Storage Locations  ##
# Pay attending to when a trailing '/' is used and when it is not
LQDIR="/mnt/cctv/archive/"
LOCALFILES="/LocalCAM/*"
LOCALSTORE="/mnt/cctv/archive/"
LOCALSTOREF="/LocalCAM"

## Record Time per File ##
LQLENGTH="3600" # (Runtime expressed in seconds)

## Store LQ files locally first, then move to NAS
## Move files in local storage older than 190 minutes
#find $LOCALSTOREF -maxdepth 1 -type f -mmin +190 -exec mv '{}' $LQDIR \;

## Record Settings ##
#
# -v 0    // Log level = 0
# -i      // Input url
# -vcidec // Set the video codec. This is an alias for "-codec:v".
# -an     // Disable audio recording
# -t      // Stop writing the output after its duration reaches duration
#
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://admin:password@192.168.1.xxx/Streaming/Channels/2" -vcodec copy -an -t $LQLENGTH $LOCALSTORE$CAM1D.mp4 &
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://admin:password@192.168.1.xxx/Streaming/Channels/2" -vcodec copy -an -t $LQLENGTH $LOCALSTORE$CAM2D.mp4 &
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://admin:password@192.168.1.xxx/h264/ch01/sub/av_stream" -vcodec copy -t $LQLENGTH $LOCALSTORE$CAM3D.mp4 &
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://admin:password@192.168.1.xxx:554/h264Preview_01_sub" -vcodec copy -t $LQLENGTH $LOCALSTORE$CAM4D.mp4 &
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://admin:password@192.168.1.xxx:554/h264Preview_01_sub" -vcodec copy -t $LQLENGTH $LOCALSTORE$CAM5D.mp4 &

