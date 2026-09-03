@'
# ORION Platform

Backend da plataforma ORION, desenvolvido em Spring Boot, containerizado com Docker e com observabilidade básica via Spring Actuator.

## Stack

- **Linguagem:** Java 25
- **Framework:** Spring Boot 4.1.0
- **Banco de dados:** PostgreSQL 18
- **Build:** Maven (via Maven Wrapper)
- **Containerização:** Docker + Docker Compose
- **Monitoramento:** Spring Boot Actuator (health checks) + logs estruturados (formato ECS/JSON)

## Estrutura do projeto

ORION-PLATAFORM/
├── backend/
│ └── orion-backend/ # API Spring Boot
│ ├── src/
│ ├── Dockerfile
│ └── pom.xml
├── docker-compose.yml # Orquestração de containers (API + banco)
├── .env.example # Template de variáveis de ambiente
└── README.md

## Como rodar o projeto

### Pré-requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado e em execução

### Passo a passo

1. Clone o repositório:
```bash
   git clone https://github.com/jeansoto516-a11y/orion-platform.git
   cd orion-platform
```

2. Copie o arquivo de variáveis de ambiente e preencha com valores reais:
```bash
   cp .env.example .env
```
   Edite o `.env` e defina `DATABASE_PASSWORD` e `JWT_SECRET`.

3. Suba o ambiente:
```bash
   docker compose up --build
```

4. A API estará disponível em `http://localhost:8081` (ajuste a porta no `docker-compose.yml` se necessário).

## Variáveis de ambiente

| Variável | Descrição |
|---|---|
| `DATABASE_PASSWORD` | Senha do usuário do banco PostgreSQL |
| `JWT_SECRET` | Chave secreta usada para assinar tokens JWT |

Veja `.env.example` para o template completo.

## Monitoramento

A aplicação expõe um endpoint de health check:

Retorna o status geral da aplicação e o status da conexão com o banco de dados.

Os logs da aplicação são emitidos em formato estruturado JSON (ECS), prontos para integração com ferramentas de observabilidade (ELK, Grafana Loki, Datadog, etc.).

## Status do projeto

Este projeto está finalizado e seguindo um escopo de entrega DevOps completo:

- [x] Containerização com Docker (API + banco)
- [x] Containerização do frontend
- [x] Estratégia de configuração (`.env.example`)
- [x] Pipeline CI/CD (GitHub Actions)
- [x] Infraestrutura como código (Terraform)
- [x] Monitoramento básico (`/actuator/health` + logs estruturados)
- [x] Estratégia de branches Git
- [x] Documentação técnica completa (arquitetura, manual de execução, decisões DevOps)

## Licença

Ainda não definida.
'@ | Out-File -FilePath README.md -Encoding utf8 -NoNewline

