#!/bin/bash

# Каталог с файлами
CERT_DIR="./env_vars"

# UID и GID пользователя postgres в контейнере
POSTGRES_UID=70
POSTGRES_GID=70

# Список файлов
CA_FILE=".ZBX_DB_CA_FILE"
CERT_FILE=".ZBX_DB_CERT_FILE"
KEY_FILE=".ZBX_DB_KEY_FILE"

echo "📁 Установка владельца и прав на TLS-файлы в $CERT_DIR"

# Назначаем владельца
sudo chown ${POSTGRES_UID}:${POSTGRES_GID} "${CERT_DIR}/${CA_FILE}"
sudo chown ${POSTGRES_UID}:${POSTGRES_GID} "${CERT_DIR}/${CERT_FILE}"
sudo chown ${POSTGRES_UID}:${POSTGRES_GID} "${CERT_DIR}/${KEY_FILE}"

# Устанавливаем права доступа
sudo chmod 644 "${CERT_DIR}/${CA_FILE}"
sudo chmod 644 "${CERT_DIR}/${CERT_FILE}"
sudo chmod 600 "${CERT_DIR}/${KEY_FILE}"

# Проверка
echo -e "\n📋 Проверка:"
ls -l "${CERT_DIR}/${CA_FILE}" "${CERT_DIR}/${CERT_FILE}" "${CERT_DIR}/${KEY_FILE}"

echo -e "\n✅ Готово!"
