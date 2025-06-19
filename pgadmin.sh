#!/bin/bash

# Запрос учетных данных
echo "Введите email для pgadmin:"
read email
echo "Введите пароль для pgadmin:"
read -s password  # Скрытый ввод пароля

# Обновление системы
apt update -y && apt upgrade -y

# Установка зависимостей
apt install -y curl gpg postgresql

# Установка pgAdmin4
curl -fsSL https://www.pgadmin.org/static/packages_pgadmin_org.pub | gpg --dearmor -o /usr/share/keyrings/pgadmin-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/pgadmin-keyring.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list

apt update -y
apt install -y pgadmin4-web

# Автоматическая настройка pgAdmin4 (неинтерактивный режим)
echo "Настройка pgAdmin4..."
sudo -u www-data /usr/pgadmin4/bin/setup-web.sh <<EOF
$email
$password
$password
EOF

# Настройка PostgreSQL (добавлено)
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '${password}';"
sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS pgadmin4;"

echo "Установка завершена!"
echo "Доступ к pgAdmin: http://$(hostname -I | awk '{print $1}')/pgadmin4"