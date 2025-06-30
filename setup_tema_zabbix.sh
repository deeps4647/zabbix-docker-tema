#!/usr/bin/env bash

echo ">>> 🗝️  Шаг 1: Генерация учетных данных PostgreSQL..."
./generate_db_credentials.sh
if [ $? -ne 0 ]; then
  echo "❌ Ошибка при выполнении generate_db_credentials.sh"
  exit 1
fi

echo ">>> 🛡️  Шаг 2: Настройка TLS (генерация сертификатов и прав)..."
./setup_tls.sh
if [ $? -ne 0 ]; then
  echo "❌ Ошибка при выполнении setup_tls.sh"
  exit 1
fi

echo ">>> 🚀 Шаг 3: Запуск Zabbix с профилем 'full'..."
sudo docker compose -f ./docker-compose_v3_alpine_pgsql_latest.yaml --profile full up -d
if [ $? -ne 0 ]; then
  echo "❌ Ошибка при запуске Docker Compose"
  exit 1
fi

echo "✅ Zabbix успешно запущен."

