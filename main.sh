#!/bin/bash

# Подключаем конфигурации и утилиты
source "$(dirname "$0")/config.sh"
source "$(dirname "$0")/utils.sh"
source "$(dirname "$0")/service_control.sh"
source "$(dirname "$0")/ui.sh"

# Загружаем версии сервисов
declare -A service_versions
load_service_versions

# Очистка при выходе
trap 'rm -f "$TEMP_FILE"' EXIT

# Запуск главного меню
main_menu
