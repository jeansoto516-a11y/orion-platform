# Arquitetura — ORION Platform

## Visão geral

Usuário
|
v
Frontend (Angular + Nginx) — porta 4200
|
v
API Backend (Spring Boot) — porta 8081
|
v
Banco PostgreSQL — porta 5433


## Componentes

### Frontend
- **Tecnologia:** Angular 21, servido em produção via Nginx (Alpine)
- **Responsabilidade:** interface de listagem e cadastro de usuários
- **Comunicação:** requisições HTTP/REST para a API backend

### API Backend
- **Tecnologia:** Spring Boot 4.1.0 (Java 25)
- **Responsabilidade:** regras de negócio, persistência de dados, exposição de endpoints REST
- **Endpoints principais:**
  - `GET /users` — lista usuários
  - `POST /users` — cadastra usuário
  - `GET /actuator/health` — health check (status da aplicação e do banco)
- **CORS:** configurado para aceitar requisições de `http://localhost:4200`

### Banco de Dados
- **Tecnologia:** PostgreSQL 18
- **Persistência:** volume Docker nomeado (`orion_pgdata`), garantindo que os dados sobrevivem a reinicializações dos containers

## Rede

Todos os serviços (frontend, API, banco) rodam na mesma rede Docker interna (`orion-net`), permitindo que a API se comunique com o banco pelo nome do serviço (`db`), sem depender de IPs fixos.

## Fluxo de dados

1. O usuário acessa o frontend pelo navegador (`localhost:4200`)
2. O Angular faz requisições HTTP para a API (`localhost:8081`)
3. A API valida a requisição, aplica CORS, e consulta/persiste dados no PostgreSQL
4. A resposta retorna em JSON para o frontend, que atualiza a tela