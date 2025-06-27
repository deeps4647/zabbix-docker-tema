#!/usr/bin/env bash

echo ">>> 🚀 Запуск генерации сертификатов..."
./generate_cert.sh
if [ $? -ne 0 ]; then
  echo "❌ Ошибка при выполнении generate_cert.sh"
  exit 1
fi

echo ">>> 🔧 Исправление прав на файлы TLS..."
./fix_tls_permissions.sh
if [ $? -ne 0 ]; then
  echo "❌ Ошибка при выполнении fix_tls_permissions.sh"
  exit 1
fi

echo "✅ Все операции TLS успешно завершены."
