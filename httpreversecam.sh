#! /usr/bin/env bash
ffmpeg -hide_banner -avoid_negative_ts make_zero -fflags nobuffer -flags low_delay -strict experimental -fflags +genpts+discardcorrupt -use_wallclock_as_timestamps 1 -f mjpeg -i http://192.168.12.1:8082 -an -r 10 -vf "hflip,scale=512:-1" -pix_fmt yuv420p -f v4l2 /dev/video0
