import { logger } from '@shared/logger';

export async function seedServer() {
  logger.log('🌱 Server seed: пока не реализовано.');
}

// Для запуска: npx ts-node src/seed/seed.ts
if (require.main === module) {
  seedServer().then(() => {
    logger.log('✅ Server seed завершён.');
  });
}

