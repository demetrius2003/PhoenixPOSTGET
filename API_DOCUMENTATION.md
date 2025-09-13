# Phoenix CRUD API Documentation

## Обзор
Этот Phoenix проект предоставляет полнофункциональный CRUD API с базой данных, валидацией и структурированным логированием. API поддерживает CORS и возвращает JSON ответы.

## Базовый URL
```
http://localhost:4000
```

## Endpoints

### Users CRUD API

#### 1. POST /api/users
Создание нового пользователя.

**Запрос:**
```bash
curl -X POST http://localhost:4000/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "age": 30,
    "bio": "Software developer",
    "is_active": true
  }'
```

**Ответ:**
```json
{
  "status": "success",
  "message": "User created successfully",
  "data": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "age": 30,
    "bio": "Software developer",
    "is_active": true,
    "metadata": {},
    "inserted_at": "2024-01-01T12:00:00Z",
    "updated_at": "2024-01-01T12:00:00Z"
  },
  "timestamp": "2024-01-01T12:00:00Z"
}
```

#### 2. GET /api/users
Получение списка пользователей с пагинацией.

**Запрос:**
```bash
curl "http://localhost:4000/api/users?limit=10&offset=0&search=john"
```

**Ответ:**
```json
{
  "status": "success",
  "message": "Users retrieved successfully",
  "data": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "age": 30,
      "bio": "Software developer",
      "is_active": true,
      "metadata": {},
      "inserted_at": "2024-01-01T12:00:00Z",
      "updated_at": "2024-01-01T12:00:00Z"
    }
  ],
  "pagination": {
    "limit": 10,
    "offset": 0,
    "total": 1,
    "has_more": false
  },
  "timestamp": "2024-01-01T12:00:00Z"
}
```

#### 3. GET /api/users/:id
Получение пользователя по ID.

**Запрос:**
```bash
curl http://localhost:4000/api/users/1
```

**Ответ:**
```json
{
  "status": "success",
  "message": "User retrieved successfully",
  "data": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "age": 30,
    "bio": "Software developer",
    "is_active": true,
    "metadata": {},
    "inserted_at": "2024-01-01T12:00:00Z",
    "updated_at": "2024-01-01T12:00:00Z"
  },
  "timestamp": "2024-01-01T12:00:00Z"
}
```

#### 4. PUT /api/users/:id
Обновление пользователя.

**Запрос:**
```bash
curl -X PUT http://localhost:4000/api/users/1 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Smith",
    "age": 31,
    "bio": "Senior software developer"
  }'
```

**Ответ:**
```json
{
  "status": "success",
  "message": "User updated successfully",
  "data": {
    "id": 1,
    "name": "John Smith",
    "email": "john@example.com",
    "age": 31,
    "bio": "Senior software developer",
    "is_active": true,
    "metadata": {},
    "inserted_at": "2024-01-01T12:00:00Z",
    "updated_at": "2024-01-01T12:01:00Z"
  },
  "timestamp": "2024-01-01T12:01:00Z"
}
```

#### 5. DELETE /api/users/:id
Удаление пользователя.

**Запрос:**
```bash
curl -X DELETE http://localhost:4000/api/users/1
```

**Ответ:**
```json
{
  "status": "success",
  "message": "User deleted successfully",
  "data": {
    "id": 1,
    "name": "John Smith",
    "email": "john@example.com",
    "age": 31,
    "bio": "Senior software developer",
    "is_active": true,
    "metadata": {},
    "inserted_at": "2024-01-01T12:00:00Z",
    "updated_at": "2024-01-01T12:01:00Z"
  },
  "timestamp": "2024-01-01T12:02:00Z"
}
```

#### 6. GET /api/users/search/:query
Поиск пользователей по имени или email.

**Запрос:**
```bash
curl http://localhost:4000/api/users/search/john
```

**Ответ:**
```json
{
  "status": "success",
  "message": "Search completed",
  "data": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "age": 30,
      "bio": "Software developer",
      "is_active": true,
      "metadata": {},
      "inserted_at": "2024-01-01T12:00:00Z",
      "updated_at": "2024-01-01T12:00:00Z"
    }
  ],
  "query": "john",
  "count": 1,
  "timestamp": "2024-01-01T12:00:00Z"
}
```

### General API

#### 7. POST /api
Отправка данных через POST запрос.

**Запрос:**
```bash
curl -X POST http://localhost:4000/api \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello", "user": "testuser"}'
```

**Ответ:**
```json
{
  "status": "success",
  "message": "POST request received",
  "data": {
    "message": "Hello",
    "user": "testuser"
  },
  "timestamp": "2024-01-01T12:00:00Z"
}
```

### 2. GET /api
Получение данных через GET запрос.

**Запрос:**
```bash
curl "http://localhost:4000/api?query=test&param=value"
```

**Ответ:**
```json
{
  "status": "success",
  "message": "GET request received",
  "data": {
    "query": "test",
    "param": "value"
  },
  "timestamp": "2024-01-01T12:00:00Z"
}
```

### 3. GET /api/status
Проверка статуса API.

**Запрос:**
```bash
curl http://localhost:4000/api/status
```

**Ответ:**
```json
{
  "status": "success",
  "message": "API is running",
  "version": "1.0.0",
  "uptime": 3600,
  "timestamp": "2024-01-01T12:00:00Z"
}
```

### 4. POST /api/echo
Эхо-сервер для тестирования.

**Запрос:**
```bash
curl -X POST http://localhost:4000/api/echo \
  -H "Content-Type: application/json" \
  -d '{"test": "data"}'
```

**Ответ:**
```json
{
  "status": "success",
  "message": "Echo endpoint",
  "echo": {
    "test": "data"
  },
  "timestamp": "2024-01-01T12:00:00Z"
}
```

### 5. GET /api/health
Проверка здоровья сервиса.

**Запрос:**
```bash
curl http://localhost:4000/api/health
```

**Ответ:**
```json
{
  "status": "healthy",
  "message": "Service is healthy",
  "checks": {
    "database": "connected",
    "memory": "ok",
    "cpu": "normal"
  },
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Валидация данных

### Поля пользователя:
- **name** (обязательное): строка, 2-100 символов
- **email** (обязательное): валидный email адрес, уникальный
- **age** (опциональное): число от 1 до 149
- **bio** (опциональное): текст до 500 символов
- **is_active** (опциональное): boolean, по умолчанию true
- **metadata** (опциональное): JSON объект

### Примеры ошибок валидации:
```json
{
  "status": "error",
  "message": "Validation failed",
  "errors": "email: must be a valid email, age: must be greater than 0",
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Логирование

API использует структурированное логирование для:
- Всех API запросов с временем выполнения
- Ошибок валидации
- Действий пользователей (создание, обновление, удаление)
- Ошибок базы данных
- Метрик производительности

## Коды ответов

- `200` - Успешный запрос
- `201` - Ресурс создан
- `400` - Ошибка в запросе (неверные данные)
- `404` - Ресурс не найден
- `422` - Ошибка валидации
- `500` - Внутренняя ошибка сервера

## Обработка ошибок

При ошибке API возвращает JSON с описанием проблемы:

```json
{
  "status": "error",
  "message": "Описание ошибки",
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## CORS
API поддерживает CORS для всех доменов (`*`). Это позволяет использовать API из браузера.

## Запуск проекта

1. Установите зависимости:
```bash
mix deps.get
```

2. Настройте базу данных:
```bash
mix ecto.setup
```

3. Запустите сервер:
```bash
mix phx.server
```

4. Откройте браузер: http://localhost:4000

## Тестирование

Используйте формы на главной странице или curl для тестирования API endpoints.

## Расширение функциональности

Для добавления новых endpoints:

1. Добавьте маршрут в `lib/hello2_web/router.ex`
2. Создайте метод в `lib/hello2_web/controllers/api_controller.ex`
3. Обновите документацию

## Структура проекта

```
lib/hello2_web/
├── controllers/
│   └── api_controller.ex    # Основной API контроллер
├── router.ex                # Маршруты
└── templates/
    └── page/
        └── index.html.eex   # Главная страница с формами
```
