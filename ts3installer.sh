#!/bin/bash

# Обновление системы
apt update && apt upgrade -y

# Создание пользователя TeamSpeak
adduser --disabled-login --gecos "" teamspeak

# Переход в временную папку
cd /tmp

# Скачивание последней версии TeamSpeak с официального сайта
LATEST_VERSION=$(curl -s https://teamspeak.com/en/downloads/#server | grep -oP 'server/(\d+\.\d+\.\d+)/teamspeak3-server_linux_amd64-\d+\.\d+\.\d+\.tar\.bz2' | head -n 1)
TS_DOWNLOAD_LINK="https://files.teamspeak-services.com/releases/${LATEST_VERSION}"
wget $TS_DOWNLOAD_LINK

# Распаковка архива
TS_VERSION=$(basename $TS_DOWNLOAD_LINK .tar.bz2)
tar xjf $TS_VERSION.tar.bz2

# Перемещение файлов TeamSpeak в /opt
mv teamspeak3-server_linux_amd64 /opt/teamspeak
chown -R teamspeak:teamspeak /opt/teamspeak

# Принятие лицензионного соглашения
touch /opt/teamspeak/.ts3server_license_accepted

# Создание systemd службы
cat <<EOT > /etc/systemd/system/teamspeak.service
[Unit]
Description=TeamSpeak 3 Server
After=network.target

[Service]
WorkingDirectory=/opt/teamspeak
User=teamspeak
Group=teamspeak
Type=forking
ExecStart=/opt/teamspeak/ts3server_startscript.sh start
ExecStop=/opt/teamspeak/ts3server_startscript.sh stop
ExecReload=/opt/teamspeak/ts3server_startscript.sh reload
PIDFile=/opt/teamspeak/ts3server.pid
RestartSec=15
Restart=always

[Install]
WantedBy=multi-user.target
EOT

# Запуск службы TeamSpeak и добавление в автозагрузку
systemctl daemon-reload
systemctl start teamspeak
systemctl enable teamspeak

# Проверка статуса
echo "TeamSpeak server status:"
systemctl status teamspeak | grep "Active:"

# Получение и вывод admin токена
sleep 5
TOKEN=$(cat /opt/teamspeak/logs/ts3server_*.log | grep "token=" | head -n 1 | cut -d'=' -f2)
echo "Your admin token is: $TOKEN"