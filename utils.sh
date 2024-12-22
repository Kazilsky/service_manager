#!/bin/bash

# Логирование сообщений
log_message() {
    local message=$1
    if $LOGGING_ENABLED; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$LOG_FILE"
    fi
}

# Чтение версии из файла
load_service_versions() {
    if [[ -f "$SERVICE_VERSION_FILE" ]]; then
        while IFS="=" read -r service version; do
            service_versions["$service"]="$version"
        done < "$SERVICE_VERSION_FILE"
    fi
}
