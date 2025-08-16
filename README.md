# K8S-Hasura-Auth - набор скриптов для развертывания тестового Backend-сервера на базе "Hasura GraphQL Engine" (GraphQL API).

## Описание проекта:

- Сервер развернут на кластере Kubernetes.
- Развернута консоль "Hasura GraphQL Engine"
- Развернут тестовый сервер JWT-аутентификации (авторизации) с добавление тестовых учетных записей (Login/Password/PayLoad) через конфигурационный файл.
- Развернут веб-сервер NGINX с FLUTTER-WEB-приложениями с доступом к HASURA (пока еще немного не готово).
- Развернута СУБД PostgreSQL с опцией "TimeScaleDB".
- Проект предназначен для тестирования GraphQL-API (проработка технологических вопросов аутентификации, авторизации, настройки "ролевого" разграничения доступа, компоновки данных и просто изучение GraphQL и т.д. и т.п.).

### Используемое ПО:

- Kubernetes 1.29 (Ingress-NGINX 1.13.0, Cert-manager 1.14.1).
- Hasura GraphQL Engine 2.46.0.
- PostgreSQL 17 + TimeScaleDB.

### Ссылки (если включить сервер):
- https://hasura.kacherno.online
- https://test1.kacherno.online
- https://test2.kacherno.online
- https://test3.kacherno.online
