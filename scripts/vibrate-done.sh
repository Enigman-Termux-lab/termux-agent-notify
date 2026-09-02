#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# Termux Agent Notify — Fast Haptic Feedback
# Легкий виброотклик по окончании выполнения команды или шага агента
# ==============================================================================
set -u

if command -v termux-vibrate >/dev/null 2>&1; then
    termux-vibrate -d 35 -f >/dev/null 2>&1 || true
fi
