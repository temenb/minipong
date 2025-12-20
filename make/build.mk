#include parameters.mk


up:
	@echo "🚀 Запуск docker compose (поднимаем все сервисы)..."
	@docker compose up -d
	@echo "✅ Сервисы запущены!"

init:
	$(call banner,"🔧 Initializing project...")
	@if [ -z "$$(ls -A services/back 2>/dev/null)" ]; then \
		echo "🔄 Initializing submodules..."; \
		git submodule update --init --recursive; \
	else \
		echo "✅ Submodules already initialized"; \
	fi
	@echo "📦 Проверка .env файлов для всех сервисов..."
	@for service in $(NODE_SERVICES) $(FLUTTER_SERVICES); do \
		ENV_PATH="$(SERVICE_DIR)/$$service/.env"; \
		ENV_EXAMPLE_PATH="$(SERVICE_DIR)/$$service/.env.example"; \
		if [ ! -f "$$ENV_PATH" ] && [ -f "$$ENV_EXAMPLE_PATH" ]; then \
			echo "[env] Копирую .env.example для $$service"; \
			cp "$$ENV_EXAMPLE_PATH" "$$ENV_PATH"; \
		fi; \
	done
	@echo "📦 Установка зависимостей в корне монорепо..."
	@pnpm install > /dev/null 2>&1
	@echo "📦 Установка зависимостей для всех сервисов..."
	@make proto-generate > /dev/null 2>&1
	@echo "🚀 Запуск docker compose (поднимаем все сервисы)..."
	@docker compose up -d > /dev/null 2>&1
	@echo "⏳ Ожидание запуска контейнеров (10 секунд)..."
	@sleep 10
	@echo '🚀 Generating Prisma clients...'
	@make prisma-generate > /dev/null 2>&1
	@echo '🚀 Apply migrations...'
	@make prisma-migrate > /dev/null 2>&1
	@make seed
	@echo "🛑 Остановка docker compose (выключаем все сервисы)..."
	@docker compose down > /dev/null 2>&1
	@echo "✅ Инициализация завершена!"
