FROM ubuntu:jammy

EXPOSE 631

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris
ENV CUPS_USER_NAME=print
ENV CUPS_USER_PASSWORD=print

RUN apt update && apt install -y \
    cups \
    whois \
    sudo \
    curl \
    samba \
    tzdata \
    printer-driver-gutenprint \
    printer-driver-all \
    printer-driver-cups-pdf \
    printer-driver-foo2zjs \
    printer-driver-foo2zjs-common \
    printer-driver-ptouch \
    printer-driver-splix \
    printer-driver-brlaser \
    printer-driver-c2esp \
    printer-driver-escpr \
    printer-driver-foo2zjs \
    && apt clean

COPY --chown=root:lp cupsd.conf /etc/cups/cupsd.conf
COPY smb.conf /etc/samba/smb.conf

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
CMD ["/bin/bash", "-c", "/usr/local/bin/entrypoint.sh && service smbd start && /usr/sbin/cupsd -f"]