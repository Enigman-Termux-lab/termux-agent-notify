#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# Termux Agent Notify — Lifecycle Hook Handler
# Отслеживание времени ответа агента и отправка Android Push при долгих задачах
# ==============================================================================
set -u

START_FILE="/tmp/agy_invoke_start"
THRESHOLD_SECONDS=300 # Порог: 5 минут

# Тактильный виброотклик по готовности любого ответа (24 миллисекунды)
if command -v termux-vibrate >/dev/null 2>&1; then
    termux-vibrate -d 24 -f >/dev/null 2>&1 || true
fi

# Проверяем, сколько времени заняла генерация
if [ -f "$START_FILE" ]; then
    START_TIME=$(cat "$START_FILE" 2>/dev/null || date +%s)
    CURRENT_TIME=$(date +%s)
    DIFF=$((CURRENT_TIME - START_TIME))
    
    if [ "$DIFF" -ge "$THRESHOLD_SECONDS" ]; then
        MINS=$((DIFF / 60))
        if command -v termux-notification >/dev/null 2>&1; then
            termux-notification \
                --id "ai-agent-done" \
                --title "AI Agent (Termux)" \
                --content "Задача выполнена! Ожидание заняло $MINS мин." \
                --priority "high" \
                --action "am start -n com.termux/com.termux.app.TermuxActivity" >/dev/null 2>&1 || true
        fi
    fi
    rm -f "$START_FILE"
fi

# Возвращаем положительное решение для hook-движка агента
echo '{"decision": "allow"}'
