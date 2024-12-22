#!/bin/bash

source "$(dirname "$0")/service_control.sh"

# Главное меню
main_menu() {
    while true; do
        local menu_items=()
        local index=1
        
        # Список сервисов
        for service in $(get_all_services); do
            local status=$(get_service_status "$service")
            menu_items+=("$index" "$service [$status]")
            ((index++))
        done
        
        # Дополнительные опции
        menu_items+=("r" "Перезапустить все сервисы")
        menu_items+=("l" "Включить/выключить логирование")
        menu_items+=("i" "Информация о запущенных скриптах")
        menu_items+=("c" "Очистка системы")
        menu_items+=("h" "Справка")
        menu_items+=("q" "Выход")
        
        dialog --title "Менеджер Сервисов" \
               --backtitle "Менеджер Сервисов v1.0" \
               --menu "Выберите сервис или действие:" \
               $DIALOG_HEIGHT $DIALOG_WIDTH $((index + 6)) \
               "${menu_items[@]}" \
               2> "$TEMP_FILE" || break
        
        local choice=$(cat "$TEMP_FILE")
        case $choice in
            [0-9]*)
                local selected_service=$(get_all_services | sed -n "${choice}p")
                [[ -n "$selected_service" ]] && manage_service "$selected_service"
                ;;
            "r")
                restart_all_services | \
                dialog --title "Перезапуск всех сервисов" --programbox $DIALOG_HEIGHT $DIALOG_WIDTH
                ;;
            "l")
                if $LOGGING_ENABLED; then
                    LOGGING_ENABLED=false
                    dialog --msgbox "Логирование выключено" 8 40
                else
                    LOGGING_ENABLED=true
                    dialog --msgbox "Логирование включено" 8 40
                fi
                ;;
            "i")
                if [[ -f "$RUNNING_SCRIPTS_FILE" ]]; then
                    dialog --title "Запущенные скрипты" \
                           --textbox "$RUNNING_SCRIPTS_FILE" \
                           $DIALOG_HEIGHT $DIALOG_WIDTH
                else
                    dialog --msgbox "Нет запущенных скриптов" 8 40
                fi
                ;;
            "c")
                cleanup_system | \
                dialog --title "Очистка системы" --programbox $DIALOG_HEIGHT $DIALOG_WIDTH
                ;;
            "h")
                dialog --title "Справка" \
                       --backtitle "Менеджер Сервисов" \
                       --msgbox "Управление сервисами:\n\n\
1. Активация сервиса:\n\
   - Автоматическое определение зависимостей\n\
   - Проверка безопасности скриптов\n\
   - Версионирование через MD5\n\
   - Обработка флагов autostart и run\n\n\
2. Алиасы:\n\
   - Автоматическое добавление в bash.bashrc\n\
   - Очистка неиспользуемых алиасов\n\
   - Защита от дубликатов\n\n\
3. Безопасность:\n\
   - Проверка опасных команд\n\
   - Контроль системных изменений\n\
   - Логирование действий\n\n\
4. Горячие клавиши:\n\
   r - Перезапуск всех сервисов\n\
   l - Управление логированием\n\
   i - Информация о скриптах\n\
   c - Очистка системы\n\
   h - Эта справка\n\
   q - Выход" \
                       $DIALOG_HEIGHT $DIALOG_WIDTH
                ;;
            "q"|"")
                clear
                break
                ;;
        esac
    done
}
