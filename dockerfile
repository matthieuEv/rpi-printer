FROM ubuntu:jammy

EXPOSE 631

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

RUN apt update && apt install -y \
    cups \
    whois \
    sudo \
    curl \
    samba \
    tzdata

RUN sudo apt install printer-driver-gutenprint -y
RUN sudo apt install -y printer-driver-all
RUN sudo apt clean

COPY --chown=root:lp cupsd.conf /etc/cups/cupsd.conf
COPY smb.conf /etc/samba/smb.conf

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
CMD ["/bin/bash", "-c", "/usr/local/bin/entrypoint.sh && service smbd start && /usr/sbin/cupsd -f"]