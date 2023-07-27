#! /usr/bin/env bash

# Give the wifi some time to start
sleep 12

# Call Home Assistant to turn on Surveillance system
curl \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJiZjA0NDhjZTYwYzQ0NzkwOTE5MzQ0OTExZGE1ZjZjYSIsImlhdCI6MTY4OTk5OTgxMCwiZXhwIjoyMDA1MzU5ODEwfQ.zQkeyO2-YvvpTIvqyy_JVJbzRgEp6IKy79BMWl0m_VQ" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "switch.surveillance_system"}' \
  -X POST http://192.168.12.1:8123/api/services/switch/turn_on

# Give it some time to start
sleep 12

# motioneye HTTP MJPEG stream to v4l2 /dev/video0
#ffmpeg -hide_banner -avoid_negative_ts make_zero -fflags nobuffer -flags low_delay -strict experimental -fflags +genpts+discardcorrupt -use_wallclock_as_timestamps 1 -f mjpeg -i http://192.168.12.1:8082 -an -r 10 -vf "hflip,scale=512:-1" -pix_fmt yuv420p -f v4l2 /dev/video0

# frigate RTSP H264 stream to v4l2 /dev/video0
cmd="ffmpeg -hide_banner -allowed_media_types video -fflags nobuffer -flags low_delay -user_agent oapi/ffmpeg -rtsp_transport tcp -i rtsp://192.168.12.1:8554/rear  -f v4l2 /dev/video0"

echo $cmd
$cmd

# repeat ffmpeg command until successful
while [ $? -ne 0 ]; do $cmd; done
