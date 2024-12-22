#!/bin/bash

source "$(dirname "$0")/utils.sh"

# Включение сервиса
enable_service() {
    local service_name=$1
    # Реализация включения сервиса
    log_message "Сервис $service_name включён"
}

# Выключение сервиса
disable_service() {
    local service_name=$1
    # Реализация выключения сервиса
    log_message "Сервис $service_name выключен"
}

# Перезапуск сервиса
restart_service() {
    local service_name=$1
    disable_service "$service_name"
    enable_service "$service_name"
    log_message "Сервис $service_name перезапущен"
}
