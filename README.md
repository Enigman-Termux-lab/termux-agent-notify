<div align="center">

# 🔔 Termux Agent Notify

### *Android Push-уведомления и тактильный виброотклик для фоновых AI-агентов в Termux*

[![Termux](https://img.shields.io/badge/Termux-Android-000000?style=for-the-badge&logo=termux&logoColor=white)](https://termux.dev/)
[![Termux:API](https://img.shields.io/badge/Termux-API-FF8C00?style=for-the-badge&logo=android&logoColor=white)](https://wiki.termux.com/wiki/Termux:API)
[![Antigravity](https://img.shields.io/badge/Antigravity-AI_Agent-orange?style=for-the-badge&logo=google&logoColor=white)](https://github.com/Enigman-Termux-lab)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

<br/>

**Termux Agent Notify** — легковесная система интеграции жизненного цикла AI-агентов ([Antigravity CLI](https://github.com/Enigman-Termux-lab), [OpenCode](https://github.com/opencode-ai), [Claude Code](https://claude.ai)) с аппаратными функциями смартфона: нативными Push-уведомлениями Android и вибромотором через `Termux:API`.

---

</div>

## 📌 Зачем это нужно?

Когда кодинг-агент выполняет сложную автономную задачу (глубокий ресерч, многошаговый рефакторинг, запуск тестов — от 3 до 10 минут):
* 😴 Пользователь переключается на другие приложения (мессенджеры, браузер) или блокирует экран телефона;
* ⏱️ Приходится постоянно вручную открывать Termux, чтобы проверить, ответил ли агент;
* 🔔 **Termux Agent Notify** решает эту проблему: телефон мягко вибрирует по готовности ответа, а если задача длилась дольше 5 минут — присылает кликабельный Push в шторку Android. Тап по уведомлению **мгновенно возвращает вас в активное окно Termux**!

---

## ⚡ Быстрая установка

### 1. Необходимые требования
Вам потребуется установленный пакет `termux-api` и соответствующее приложение [Termux:API](https://f-droid.org/packages/com.termux.api/) из F-Droid:
```bash
pkg update && pkg install termux-api -y
```

### 2. Установка скриптов
```bash
git clone https://github.com/Enigman-Termux-lab/termux-agent-notify.git
cd termux-agent-notify
bash scripts/install-hooks.sh
```

---

## ⚙️ Настройка в хуках агентов (Hooks)

### Для Antigravity CLI:
Добавьте хук в конфигурационный файл `~/.gemini/antigravity-cli/hooks.json`:
```json
{
  "termux-notify": {
    "PreInvocation": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'date +%s > /tmp/agy_invoke_start; echo "{\"decision\": \"allow\"}"'",
            "timeout": 5
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.config/agent-notify/notify-hook.sh",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

---

## 🛠 Компоненты системы

* **[`scripts/notify-hook.sh`](scripts/notify-hook.sh)** — умный обработчик: замеряет разницу между стартом и финишем задачи, активирует микро-вибрацию (24 мс) и при превышении тайм-аута вызывает `termux-notification` с интерактивным переходом `am start -n com.termux/...`.
* **[`scripts/vibrate-done.sh`](scripts/vibrate-done.sh)** — автономный скрипт тактильного отклика (удобно вызывать в конце длинных bash-команд: `git clone ... && vibrate-done.sh`).
* **[`skill/SKILL.md`](skill/SKILL.md)** — спецификация интеграции для AI-агентов.

---

## 📄 Лицензия

Распространяется под лицензией [MIT](LICENSE). Разработано для открытой экосистемы **[Enigman-Termux-lab](https://github.com/Enigman-Termux-lab)**.
