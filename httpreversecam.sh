#! /usr/bin/env bash

# motioneye HTTP MJPEG stream to v4l2 /dev/video0
#ffmpeg -hide_banner -avoid_negative_ts make_zero -fflags nobuffer -flags low_delay -strict experimental -fflags +genpts+discardcorrupt -use_wallclock_as_timestamps 1 -f mjpeg -i http://192.168.12.1:8082 -an -r 10 -vf "hflip,scale=512:-1" -pix_fmt yuv420p -f v4l2 /dev/video0

# frigate RTSP H264 stream to v4l2 /dev/video0
cmd="ffmpeg -hide_banner -allowed_media_types video -fflags nobuffer -flags low_delay -user_agent oapi/ffmpeg -rtsp_transport tcp -i rtsp://192.168.12.1:8554/rear -an -r 10 -vf \"hflip,scale=512:-1\" -pix_fmt yuv420p -g 10 -bf 0 -f v4l2 /dev/video0"

echo $cmd
$cmd

# repeat last command until successful
while [ $? -ne 0 ]; do $cmd; done
