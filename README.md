# K8S-Hasura-Auth - набор скриптов для развертывания GraphQL Backend-сервера на базе "Hasura GraphQL Engine".

## Описание проекта:

- Сервер развернут на кластере Kubernetes.
- Присутствует сервер JWT-аутентификации (авторизации) с добавление тестовых учетных записей (Login/Password/PayLoad) через конфигурационный файл.
- СУБД PostgreSQL с опцией "TimeScaleDB".
- Проект предназначен для тестирования.

### Используемое ПО:

- Kubernetes 1.29 (Ingress-NGINX 1.13.0, Cert-manager 1.14.1).
- Hasura GraphQL Engine 2.46.0.
- PostgreSQL 17 + TimeScaleDB.

