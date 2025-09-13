# Phoenix CRUD API

Полнофункциональный CRUD API на Phoenix с базой данных, валидацией и структурированным логированием.

## Возможности

✅ **Полный CRUD** - Create, Read, Update, Delete операции
✅ **База данных** - PostgreSQL с Ecto ORM
✅ **Валидация** - Ecto Changeset с детальными ошибками
✅ **Логирование** - Структурированные логи всех операций
✅ **Пагинация** - Поддержка limit/offset для списков
✅ **Поиск** - Поиск пользователей по имени и email
✅ **CORS** - Поддержка кросс-доменных запросов
✅ **Тесты** - Полное покрытие тестами
✅ **Документация** - Подробная API документация

## Быстрый старт

### Windows
```bash
start.bat
```

### Linux/Mac
```bash
chmod +x start.sh
./start.sh
```

### Ручной запуск
```bash
# Установка зависимостей
mix deps.get

# Настройка базы данных
mix ecto.setup

# Запуск миграций
mix ecto.migrate

# Запуск сервера
mix phx.server
```

## API Endpoints

### Users CRUD
- `POST /api/users` - Создать пользователя
- `GET /api/users` - Список пользователей (с пагинацией)
- `GET /api/users/:id` - Получить пользователя по ID
- `PUT /api/users/:id` - Обновить пользователя
- `DELETE /api/users/:id` - Удалить пользователя
- `GET /api/users/search/:query` - Поиск пользователей

### General API
- `POST /api` - Общий POST endpoint
- `GET /api` - Общий GET endpoint
- `GET /api/status` - Статус API
- `POST /api/echo` - Эхо-сервер
- `GET /api/health` - Проверка здоровья

## Примеры использования

### Создание пользователя
```bash
curl -X POST http://localhost:4000/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "age": 30,
    "bio": "Software developer"
  }'
```

### Получение списка пользователей
```bash
curl "http://localhost:4000/api/users?limit=10&offset=0"
```

### Поиск пользователей
```bash
curl "http://localhost:4000/api/users/search/john"
```

### Обновление пользователя
```bash
curl -X PUT http://localhost:4000/api/users/1 \
  -H "Content-Type: application/json" \
  -d '{"name": "John Smith", "age": 31}'
```

### Удаление пользователя
```bash
curl -X DELETE http://localhost:4000/api/users/1
```

## Валидация

API включает строгую валидацию данных:

- **name**: обязательное, 2-100 символов
- **email**: обязательное, валидный email, уникальный
- **age**: опциональное, 1-149 лет
- **bio**: опциональное, до 500 символов
- **is_active**: опциональное, boolean
- **metadata**: опциональное, JSON объект

## Логирование

Все операции логируются в структурированном формате:

```json
{
  "type": "api_request",
  "method": "POST",
  "path": "/api/users",
  "status": 201,
  "duration_ms": 45,
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Тестирование

Запуск тестов:
```bash
mix test
```

Запуск тестов с покрытием:
```bash
mix test --cover
```

## Структура проекта

```
lib/
├── hello2/
│   ├── users/
│   │   └── user.ex           # Ecto схема пользователя
│   ├── users.ex              # Контекст пользователей
│   └── logger.ex             # Модуль логирования
└── hello2_web/
    ├── controllers/
    │   ├── api_controller.ex # Общие API endpoints
    │   └── user_controller.ex # CRUD контроллер
    ├── plugs/
    │   └── request_logger.ex # Plug для логирования
    └── router.ex             # Маршруты
```

## Конфигурация

### База данных
Настройка в `config/dev.exs`:
```elixir
config :hello2, Hello2.Repo,
  username: "postgres",
  password: "postgres",
  database: "hello2_dev",
  hostname: "localhost"
```

### Логирование
Логи выводятся в консоль в формате:
```
[info] API Request type=api_request method=POST path=/api/users status=201 duration_ms=45
```

## Развертывание

1. Настройте переменные окружения для production
2. Запустите миграции: `mix ecto.migrate`
3. Соберите статические файлы: `mix phx.digest`
4. Запустите сервер: `mix phx.server`

## Мониторинг

- **Health check**: `GET /api/health`
- **Status**: `GET /api/status`
- **LiveDashboard**: `http://localhost:4000/dashboard` (только в dev)

## Дальнейшее развитие

- [ ] Аутентификация (JWT)
- [ ] Авторизация (роли и права)
- [ ] Rate limiting
- [ ] Кэширование (Redis)
- [ ] Swagger документация
- [ ] GraphQL API
- [ ] WebSocket поддержка
- [ ] Docker контейнеризация
