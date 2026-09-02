#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# Termux Agent Notify — Hook Installer for Antigravity CLI / AI Agents
# ==============================================================================
set -euo pipefail

echo "🔔 Установка Termux Agent Notify..."

# Проверяем наличие пакета Termux:API
if ! command -v termux-notification >/dev/null 2>&1; then
    echo "📦 Установка пакета termux-api..."
    pkg update -y && pkg install termux-api -y
    echo "⚠️ Убедитесь, что приложение Termux:API установлено из F-Droid!"
fi

TARGET_DIR="$HOME/.config/agent-notify"
mkdir -p "$TARGET_DIR"

cp scripts/notify-hook.sh "$TARGET_DIR/notify-hook.sh"
cp scripts/vibrate-done.sh "$TARGET_DIR/vibrate-done.sh"
chmod +x "$TARGET_DIR"/*.sh

echo "🟢 Скрипты скопированы в $TARGET_DIR"
echo "Пример конфигурации хуков (hooks.json) сохранен в README.md"
