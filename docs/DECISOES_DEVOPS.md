# Decisões Técnicas de DevOps — ORION Platform

## Containerização

**Build multi-stage para backend e frontend.** Tanto a API (Java) quanto o frontend (Angular) usam Dockerfiles com duas etapas: uma para compilar/buildar, outra apenas para executar. Isso reduz drasticamente o tamanho final das imagens, já que ferramentas de build (Maven, Node) não vão para a imagem de produção.

**Nginx para servir o frontend.** Em vez de manter um servidor Node.js rodando em produção só para servir arquivos estáticos, o frontend compilado é entregue por Nginx — mais leve e mais adequado para esse tipo de carga.

**SSR (Server-Side Rendering) desativado no Angular.** O projeto foi gerado inicialmente com SSR habilitado por padrão (novidade do Angular 21), mas essa característica é voltada para SEO/performance de sites públicos — desnecessária para um painel interno de CRUD. Foi removido para simplificar o projeto e evitar problemas de hidratação client-side.

## Rede e comunicação entre serviços

Os serviços (API, banco, frontend) compartilham uma rede Docker interna (`orion-net`). A API se conecta ao banco pelo nome do serviço (`db`), não por IP fixo ou `localhost` — essa é a prática recomendada em ambientes Docker Compose, pois o nome do serviço é resolvido automaticamente pela rede interna do Docker.

## Persistência de dados

O PostgreSQL 18 usa um volume Docker nomeado (`orion_pgdata`) montado em `/var/lib/postgresql` (não em `/var/lib/postgresql/data`, que era o padrão em versões anteriores — a partir da versão 18, a imagem oficial do Postgres reorganiza os dados em subpastas por versão).

## Configuração e segredos

Nenhuma credencial (senha de banco, chave JWT) está no código-fonte. Todas são lidas via variáveis de ambiente, com valores reais mantidos em um `.env` (ignorado pelo Git) e documentados em `.env.example` (sem valores reais, apenas os nomes das variáveis esperadas).

## Monitoramento

**Spring Boot Actuator** foi escolhido para o health check (`/actuator/health`) por ser a solução nativa e oficial do framework, evitando reinventar essa funcionalidade manualmente. Ele reporta tanto o status geral da aplicação quanto o status da conexão com o banco de dados.

**Logs estruturados em formato ECS (Elastic Common Schema)**, via recurso nativo do Spring Boot (`logging.structured.format.console=ecs`), sem necessidade de bibliotecas adicionais. Esse formato é amplamente reconhecido por ferramentas de observabilidade (ELK, Grafana Loki, Datadog), facilitando uma futura integração.

## Estratégia de branches

Modelo `main ? develop ? feature/* ? hotfix/*`, documentado em `CONTRIBUTING.md`. A proteção da branch `main` (Pull Request obrigatório) foi configurada inicialmente, mas posteriormente desativada por decisão de fluxo de trabalho do time — ponto em aberto para reavaliação futura, caso o critério de aceite do escopo original precise ser cumprido integralmente.

## Pendências conhecidas

- Pipeline de CI/CD (GitHub Actions) ainda não implementada

- Alertas automáticos de indisponibilidade não implementados (dependem de uma ferramenta de observabilidade externa conectada aos logs/métricas já expostos)

## Infraestrutura como Codigo (Terraform)

Como o projeto nao possui conta em provedor de nuvem (AWS/Azure/GCP), a infraestrutura como codigo foi implementada usando o provider Docker do Terraform (kreuzwerker/docker), gerenciando os mesmos recursos do docker-compose (rede, volume, containers) de forma declarativa e versionada, em infra/terraform/.

Essa e uma adaptacao pratica do item de escopo original (criar VM ou servico equivalente via Terraform) para a realidade do ambiente disponivel. A migracao para um provider de nuvem real (aws, azurerm, google) seria a evolucao natural do projeto, reaproveitando a mesma estrutura de variaveis e outputs ja definida.

Validado com sucesso via terraform init, terraform plan e terraform apply (banco de dados e API criados e funcionais). O build da imagem do frontend demonstrou ser sensivel a memoria RAM alocada ao Docker Desktop; em ambientes com poucos recursos, recomenda-se aumentar a alocacao de memoria antes de rodar terraform apply com multiplas imagens em paralelo.
