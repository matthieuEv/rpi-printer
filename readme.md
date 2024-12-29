```docker-compose
services:
  rpi-print:
    container_name: rpi-print
    image: ghcr.io/matthieuev/rpi-print:latest
    ports:
      - "631:631"
    environment:
      - CUPS_USER_NAME=admin
      - CUPS_USER_PASSWORD=password
    restart: unless-stopped
    devices:
      - /dev/bus/usb:/dev/bus/usb
```