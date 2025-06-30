#!/usr/bin/env bash

# Каталог, где будут храниться файлы
TARGET_DIR="env_vars"

# Получаем timestamp
timestamp=$(date +"%Y%m%d_%H%M%S")

echo ">>> 🔍 Проверяю наличие предыдущих файлов в '$TARGET_DIR'..."

# Список файлов
PASSWORD_FILE=".POSTGRES_PASSWORD"
USER_FILE=".POSTGRES_USER"

# Переименовываем старые файлы, если они есть
for f in "$PASSWORD_FILE" "$USER_FILE"; do
  if [ -e "$TARGET_DIR/$f" ]; then
    new_name="$TARGET_DIR/.old_${timestamp}_${f#'.'}"
    mv "$TARGET_DIR/$f" "$new_name"
    echo "Найден файл '$f' -> переименован в '$(basename "$new_name")'"
  fi
done

echo ">>> 🔐 Генерация пароля PostgreSQL..."

# Генерация случайного пароля из больших/маленьких букв и цифр, длина 15
password=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c15)

# Генерация суффикса из 8 символов (маленькие буквы и цифры)
suffix=$(tr -dc 'a-z0-9' </dev/urandom | head -c8)

# Имя пользователя
username="zabbixdb${suffix}"

echo ">>> 💾 Сохраняю файлы..."

# Записываем пароль в одну строку
printf "%s" "$password" > "$TARGET_DIR/$PASSWORD_FILE"

# Записываем имя пользователя в одну строку
printf "%s" "$username" > "$TARGET_DIR/$USER_FILE"

# Устанавливаем права
chmod 600 "$TARGET_DIR/$PASSWORD_FILE"
chmod 600 "$TARGET_DIR/$USER_FILE"

echo ">>> 📋 Проверка созданных файлов:"
ls -l "$TARGET_DIR/$PASSWORD_FILE" "$TARGET_DIR/$USER_FILE"

echo -e "\n✅ Скрипт успешно завершён."
