#!/bin/bash

SERVICES_DIR="/opt/bash_scripts"
ENABLE_DIR="/opt/bash_scripts/active_services"
RUNNING_SCRIPTS_FILE="/tmp/running_scripts.txt"
BASHRC_FILE="/etc/bash.bashrc"
SERVICE_VERSION_FILE="/opt/bash_scripts/service_versions.txt"
LOG_FILE="/var/log/service_manager.log"
DIALOG_HEIGHT=20
DIALOG_WIDTH=70
TEMP_FILE=$(mktemp)
LOGGING_ENABLED=false
