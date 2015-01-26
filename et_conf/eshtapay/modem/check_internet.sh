ping -c 1 8.8.8.8
if [$? -eq  1]; then
  /usr/bin/notify-bin "Connection to Internet is missing"
fi
