FROM debian:trixie-slim

EXPOSE 631

RUN apt update && apt install -y \
    cups \
    whois \
    sudo \
    curl \
    samba \
    printer-driver-all \
    printer-driver-gutenprint \
    && apt clean

COPY --chown=root:lp cupsd.conf /etc/cups/cupsd.conf
COPY smb.conf /etc/samba/smb.conf

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
CMD ["/bin/bash", "-c", "/usr/local/bin/entrypoint.sh && service smbd start && /usr/sbin/cupsd -f"]