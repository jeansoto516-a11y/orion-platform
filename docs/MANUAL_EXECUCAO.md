# Manual de Execução — ORION Platform

## Pré-requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado e em execução
- Git instalado

## Como iniciar o ambiente

1. Clone o repositório:
```bash
   git clone https://github.com/jeansoto516-a11y/orion-platform.git
   cd orion-platform
```

2. Copie o arquivo de variáveis de ambiente:
```bash
   cp .env.example .env
```
   Edite o `.env` e defina valores reais para `DATABASE_PASSWORD` e `JWT_SECRET`.

3. Suba todo o ambiente (banco, API e frontend):
```bash
   docker compose up --build
```

4. Acesse:
   - **Frontend:** http://localhost:4200
   - **API:** http://localhost:8081
   - **Health check:** http://localhost:8081/actuator/health

## Como parar o ambiente

```bash
docker compose down
```

Para remover também os dados persistidos do banco:
```bash
docker compose down -v
```

## Como executar testes

*(Ainda não implementado — os testes automatizados estão previstos na pipeline de CI/CD, item em desenvolvimento.)*

## Como realizar deploy

*(Ainda não implementado — a automação de deploy está prevista para a etapa de CI/CD + Infraestrutura como Código, itens em desenvolvimento.)*

## Rodando localmente sem Docker (desenvolvimento)

### Backend
```bash
cd backend/orion-backend
$env:DATABASE_PASSWORD="sua_senha"
$env:JWT_SECRET="seu_secret"
./mvnw spring-boot:run
```
Requer um PostgreSQL rodando localmente, com banco `orion_db` e usuário `orion_user` criados.

### Frontend
```bash
cd frontend
ng serve
```
Acesse http://localhost:4200. Requer a API rodando (local ou via Docker) na porta 8081, já que o frontend está configurado para consumi-la nesse endereço.