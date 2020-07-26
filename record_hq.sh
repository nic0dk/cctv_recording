#!/bin/sh
# record_hq.sh
# Record ip cam in segments

# This will print the current date and time in a format appropriate for storage
STARTTIME=$(/bin/date +"%m.%d.%Y")_"["$(/bin/date +"%H")h_$(/bin/date +"%M")m_$(/bin/date +"%S")s"]"

## IP Camera Names ##
# Creating date stamps for each of the five cameras
CAM1D=indkorsel_$STARTTIME
CAM2D=terrasse_$STARTTIME
CAM3D=hoveddor_$STARTTIME
CAM4D=terrasseSV_$STARTTIME
CAM5D=terrasseNV_$STARTTIME

## Network and Local Storage Locations  ##
HQDIR="/mnt/cctv/video/" #Trailing '/' is necessary here

## Record Time per File ##
HQLENGTH="900" # (Runtime expressed in seconds)

## Record Settings ##
#
# -v 0    // Log level = 0
# -i      // Input url
# -vcidec // Set the video codec. This is an alias for "-codec:v".
# -an     // Disable audio recording
# -t      // Stop writing the output after its duration reaches duration
#
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://admin:password@192.168.1.xxx/cam1/onvif-h264-1" -vcodec copy -an -t $HQLENGTH $HQDIR$CAM1D.mp4 &
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://admin:password@192.168.1.xxx/cam1/onvif-h264-1" -vcodec copy -an -t $HQLENGTH $HQDIR$CAM2D.mp4 &
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://admin:password@192.168.1.xxx/h264/ch01/main/av_stream" -vcodec copy -t $HQLENGTH $HQDIR$CAM3D.mp4 &
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://admin:password@192.168.1.xxx:554/h264Preview_01_main" -vcodec copy -t $HQLENGTH $HQDIR$CAM4D.mp4 &
ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://admin:password@192.168.1.xxx:554/h264Preview_01_main" -vcodec copy -t $HQLENGTH $HQDIR$CAM5D.mp4 &

