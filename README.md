# minipong

Приложение для ведения счета настольного тенниса.

## Возможности

- Добавление и выбор игроков
- Ведение счета для двух игроков
- Сохранение партий
- Управление режимом смены подачи (2 или 5 ходов)
- Быстрое добавление голов с помощью кнопок и горячих клавиш (Ctrl/Space/Enter)
- История голов и партий

## Установка и запуск из монорепозитория

1. Установите [pnpm](https://pnpm.io/):
   ```bash
   npm install -g pnpm
   ```
2. Установите зависимости для всех пакетов:
   ```bash
   pnpm install
   ```
3. Для запуска backend-сервисов используйте:
   ```bash
   pnpm run dev -F services/auth
   pnpm run dev -F services/engine
   pnpm run dev -F services/gateway
   pnpm run dev -F services/profile
   ```
   Или запустите все сервисы через Docker Compose:
   ```bash
   docker-compose up --build
   ```
4. Для запуска фронтенда (Flutter):
   ```bash
   cd front
   flutter pub get
   flutter run
   

