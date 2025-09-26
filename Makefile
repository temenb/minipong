include parameters.mk

NODE_BIN=./node_modules/.bin
SERVICE_DIR := services

PROTO_FILES := $(shell find proto -name '*.proto')


NODE_PROTO_PATH=./src/grpc/generated
FLUTTER_PROTO_PATH=./lib/src/grpc/generated

install:
	@echo "🔧 Инициализация проекта"
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
	pnpm install
	@echo "📦 Установка зависимостей для всех сервисов..."
	make proto-generate
	@echo "🚀 Запуск docker compose (поднимаем все сервисы)..."
	docker compose up -d
	@echo "⏳ Ожидание запуска контейнеров (10 секунд)..."
	sleep 10
	@echo "🔍 Генерация Prisma клиентов для всех сервисов..."
	make prisma-generate
	@echo "🚀 Применение миграций Prisma для всех сервисов..."
	make prisma-migrate
	@echo "🌱 Запуск сидов для всех сервисов..."
	make seed
	@echo "👤 Создание админа через gateway..."

prisma-migrate:
	@echo '🚀 Apply migrations...'
	@for service in $(PRISMA_SERVICES); do \
		echo "▶️  Running migrations for $$service..."; \
		docker compose exec -T -w /usr/src/app/services/$$service $$service npx prisma migrate dev --schema=prisma/schema.prisma; \
	done

prisma-generate:
	@echo '🚀 Generating Prisma clients...'
	@for service in $(PRISMA_SERVICES); do \
		echo '🚀 Generating' $$service 'Prisma client...' && \
		docker cp ./$(SERVICE_DIR)/$$service/prisma game-$$service:/usr/src/app/$(SERVICE_DIR)/$$service/prisma; \
		docker compose exec -T -w /usr/src/app/services/$$service $$service npx prisma generate; \
    done

seed:
	@echo "🌱 Запуск сидов"
	@for service in $(PRISMA_SERVICES); do \
		docker compose exec -T -w /usr/src/app/services/$$service $$service npx ts-node src/seed/seed.ts; \
    done

commit-all:
	@for dir in $(GIT_SERVICES); do \
		echo "\033[1;33m[*] Checking $$dir...\033[0m"; \
		SERVICE_PATH="$(SERVICE_DIR)/$$dir"; \
		if [ ! -d "$$SERVICE_PATH/.git" ]; then \
			echo "\033[0;31m[!] Skipping $$dir — not a git repo\033[0m"; \
			continue; \
		fi; \
		cd "$$SERVICE_PATH"; \
		if git diff --quiet; then \
			echo "\033[1;33m[-] No changes in $$dir\033[0m"; \
		else \
			if [ "$(DRY_RUN)" = "true" ]; then \
				echo "\033[0;32m[DRY-RUN] Would commit changes in $$dir\033[0m"; \
			else \
				git add . && \
				git commit -am "$(COMMIT_MSG)" && \
				echo "git commit -am \"$(COMMIT_MSG)\"" && \
				if git push; then \
					echo "\033[0;32m[✓] Committed changes in $$dir\033[0m"; \
				else \
					echo "\033[0;31m[✗] Failed to push $$dir\033[0m"; \
				fi; \
			fi; \
		fi; \
		cd - > /dev/null; \
    done

	@echo "\033[1;33m[*] Checking monorepo...\033[0m"
	if git diff --quiet; then \
		echo "\033[1;33m[-] No changes in monorepo\033[0m"; \
	else \
		if [ "$(DRY_RUN)" = "true" ]; then \
			echo "\033[0;32m[DRY-RUN] Would commit changes in monorepo\033[0m"; \
		else \
			git add . && \
			git commit -am "$(COMMIT_MSG)" && \
			echo "git commit -am \"$(COMMIT_MSG)\"" && \
			if git push; then \
				echo "\033[0;32m[✓] Committed changes in monorepo\033[0m"; \
			else \
				echo "\033[0;31m[✗] Failed to push monorepo\033[0m"; \
			fi; \
		fi; \
	fi;

proto-generate:
	@echo '🚀 Proto generate...'

	@for dir in $(NODE_SERVICES); do \
		echo "\033[1;33m[*] Checking $$dir...\033[0m"; \
		rm -rf $(SERVICE_DIR)/$$dir/${NODE_PROTO_PATH}; \
		mkdir -p $(SERVICE_DIR)/$$dir/${NODE_PROTO_PATH}; \
	done

	@for dir in $(FLUTTER_SERVICES); do \
		echo "\033[1;33m[*] Checking $$dir...\033[0m"; \
		rm -rf $(SERVICE_DIR)/$$dir/${FLUTTER_PROTO_PATH}; \
		mkdir -p $(SERVICE_DIR)/$$dir/${FLUTTER_PROTO_PATH}; \
	done

	@for dir in $(NODE_SERVICES); do \
		echo "\033[1;34m[>] Generating proto for $$dir...\033[0m"; \
		npx protoc \
			--plugin=./node_modules/.bin/protoc-gen-ts_proto \
			--ts_proto_out=$(SERVICE_DIR)/$$dir/${NODE_PROTO_PATH} \
			--ts_proto_opt=outputServices=grpc-js,useExactTypes=false,esModuleInterop=true \
			--proto_path=./proto \
			$(PROTO_FILES); \
		echo "\033[1;32m[✓] $$dir done\033[0m"; \
	done

	@for dir in $(FLUTTER_SERVICES); do \
		echo "\033[1;34m[>] Generating proto for $$dir...\033[0m"; \
		protoc \
			--dart_out=grpc:$(SERVICE_DIR)/$$dir/${FLUTTER_PROTO_PATH} \
			--proto_path=./proto \
			$(PROTO_FILES); \
		echo "\033[1;32m[✓] $$dir done\033[0m"; \
	done





kafka-list-topics:
	docker compose exec kafka kafka-topics.sh --bootstrap-server localhost:9092 --list

kafka-user-created-list:
	docker compose exec kafka \
	kafka-console-consumer.sh \
	--bootstrap-server localhost:9092 \
	--topic user.created \
	--from-beginning





#test:
#	@echo "🧪 Запуск тестов"
#	$(NODE_BIN)/jest
#
## 🛠️ Установка зависимостей
#test:
#	@echo "🧪 Запуск тестов"
#	npx turbo run test