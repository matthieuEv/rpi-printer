Default user and password are `print` and `print`. You can change them by setting the environment variables `CUPS_USER_NAME` and `CUPS_USER_PASSWORD`.

Default Timezone is `Europe/Paris`. You can change it by setting the environment variable `TZ`.

```docker-compose
services:
  rpi-print:
    container_name: rpi-print
    image: ghcr.io/matthieuev/rpi-print:latest
    ports:
      - "631:631"
    environment:
      - CUPS_USER_NAME=print
      - CUPS_USER_PASSWORD=print
      - TZ=Europe/Paris
    restart: unless-stopped
    devices:
      - /dev/bus/usb:/dev/bus/usb
```