#!/usr/bin/env bash

# Папка, где будут храниться сертификаты
TARGET_DIR="env_vars"

# Получаем timestamp
timestamp=$(date +"%Y%m%d_%H%M%S")

echo ">>> Начинаю проверку существующих файлов в '$TARGET_DIR'..."

# Переименовываем старые файлы, если они есть
for f in .ZBX_DB_CERT_FILE .ZBX_DB_KEY_FILE .ZBX_DB_CA_FILE; do
  if [ -e "$TARGET_DIR/$f" ]; then
    new_name="$TARGET_DIR/.old_${timestamp}_${f#'.'}"
    mv "$TARGET_DIR/$f" "$new_name"
    echo "Найден файл: '$f' -> переименован в '$(basename "$new_name")'"
  fi
done

echo ">>> Генерирую новый ключ и сертификат..."

# Генерируем новый ключ и сертификат
openssl req -x509 -nodes -days 18250 \
  -newkey rsa:2048 \
  -keyout "$TARGET_DIR/.ZBX_DB_KEY_FILE" \
  -out "$TARGET_DIR/.ZBX_DB_CERT_FILE" \
  -config "openssl.cnf" \
  -extensions v3_req

# Копируем сертификат как CA
cp "$TARGET_DIR/.ZBX_DB_CERT_FILE" "$TARGET_DIR/.ZBX_DB_CA_FILE"

echo ">>> Сгенерированы файлы:"
echo " - .ZBX_DB_KEY_FILE"
echo " - .ZBX_DB_CERT_FILE"
echo " - .ZBX_DB_CA_FILE"

echo ">>> ✅ Скрипт успешно завершён."
