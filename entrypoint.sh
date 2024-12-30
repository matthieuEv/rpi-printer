#!/bin/bash

# Créer l'utilisateur
useradd --groups=sudo,lp,lpadmin --create-home --home-dir=/home/$CUPS_USER_NAME --shell=/bin/bash --password=$(mkpasswd $CUPS_USER_PASSWORD) $CUPS_USER_NAME

# Configurer sudoers
sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Ajouter à lpadmin
sudo usermod -aG lpadmin $CUPS_USER_NAME

# Démarrer le service
service cups start
service smbd start

# Garder le conteneur ouvert
tail -f /dev/null
