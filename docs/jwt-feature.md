# Пошаговый план внедрения авторизации и интеграции с Gateway

---

## Подготовка инфраструктуры
1. Создать и загрузить приватный/публичный ключи для подписи JWT в сервис Auth.  
2. Экспортировать публичный ключ для проверки токенов в Gateway.  
3. Добавить миграции БД:  
   - **Auth:** таблица `users` (`id`, `deviceId`, `googleId`, `facebookId`, `createdAt`).  
   - **Profile:** таблица `profiles` (`id`, `userId`, `createdAt`).  

---

## Реализация в Auth
4. Добавить gRPC метод **GuestRegister/Login**:  
   - Вход: `deviceId`.  
   - Логика: найти или создать пользователя, вернуть `userId`.  
   - При создании — вызвать Profile для создания профиля.  

5. Добавить gRPC метод **IssueJWT**:  
   - Вход: `userId`.  
   - Логика: подписать JWT с `userId`, `profileId`, `authMethod`.  
   - Выход: `token`, `exp`.  

6. Добавить gRPC метод **SocialLogin**:  
   - Вход: `provider`, `providerToken`, `currentDeviceId`.  
   - Логика: проверить токен у провайдера.  
     - Если соц‑ID найден — вернуть `userId`.  
     - Если нет — привязать соц‑ID к текущему гостю.  
   - Выдать JWT через **IssueJWT**.  

---

## Интеграция в Profile
7. Добавить gRPC метод **CreateProfileIfMissing**:  
   - Проверить наличие профиля, при отсутствии создать.  

8. Добавить gRPC метод **GetProfile**:  
   - Вернуть профиль по `userId`.  

---

## Интеграция в Gateway
9. Настроить загрузку и кэширование публичного ключа JWT.  
10. Добавить JWT‑middleware:  
    - Проверка подписи и срока действия.  
    - Извлечение `userId`, `profileId`, `authMethod`.  
    - Ошибки → `UNAUTHENTICATED`.  
11. Пробрасывать контекст (`userId`, `profileId`) в downstream gRPC вызовы.  

---

## Клиент Flutter
12. Сгенерировать и сохранить `deviceId` при первом запуске.  
13. Реализовать поток гостя:  
    - Вызвать `GuestRegister/Login`.  
    - Получить JWT через `IssueJWT`.  
    - Вызвать `GetProfile`.  
14. Реализовать поток соцлогина:  
    - Получить `providerToken`.  
    - Вызвать `SocialLogin`.  
    - Сохранить новый JWT.  
15. Прикреплять JWT ко всем gRPC вызовам.  

---

## Завершение и проверка
16. Обновить health‑чек: проверка ключей JWT и готовности Auth/Profile.  
17. Написать тесты:  
    - Юнит: создание гостя, привязка соц‑ID, выдача JWT.  
    - Интеграция: Flutter → Gateway → Auth → Profile.  
18. Деплой по этапам:  
    - Миграции БД.  
    - Обновление Auth (методы, ключи).  
    - Обновление Gateway (middleware).  
    - Обновление Profile.  
    - Обновление Flutter.  
19. Настроить мониторинг:  
    - Логи ошибок `UNAUTHENTICATED`.  
    - Метрики `GuestRegister/Login` и `SocialLogin`.  
