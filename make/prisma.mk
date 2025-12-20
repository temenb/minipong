.PHONY: prisma-migrate prisma-generate seed

PRISMA_SERVICES := auth profile engine fallout

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
		docker cp ./$(SERVICE_DIR)/$$service/prisma $$service:/usr/src/app/$(SERVICE_DIR)/$$service/prisma; \
		docker compose exec -T -w /usr/src/app/services/$$service $$service npx prisma generate; \
    done

seed:
	@echo "🌱 Запуск сидов"
	@for service in $(PRISMA_SERVICES); do \
		docker compose exec -T -w /usr/src/app/services/$$service $$service npx ts-node src/seed/seed.ts; \
    done
