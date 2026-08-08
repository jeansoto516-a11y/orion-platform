@'
# Guia de Contribuição — ORION Platform

## Estratégia de branches

main
└── develop
└── feature/*
└── hotfix/*

- **`main`** — branch de produção/homologação. Protegida: só recebe merge via Pull Request aprovado.
- **`develop`** — branch de integração. Todo trabalho novo nasce a partir dela.
- **`feature/*`** — uma branch por funcionalidade, criada a partir da `develop`.
- **`hotfix/*`** — correções urgentes, criadas a partir da `main`.

## Fluxo de trabalho

### 1. Criar uma nova feature

```bash
git checkout develop
git pull origin develop
git checkout -b feature/nome-da-funcionalidade
```

### 2. Desenvolver e commitar

Use mensagens de commit descritivas, seguindo o padrão:

tipo: descrição curta

feat: nova funcionalidade
fix: correção de bug
docs: alteração de documentação
chore: tarefas de manutenção (config, dependências)

### 3. Enviar a branch e abrir Pull Request

```bash
git push -u origin feature/nome-da-funcionalidade
```

No GitHub, abra um Pull Request de `feature/nome-da-funcionalidade` → `develop`.

### 4. Promover para produção

Quando a `develop` estiver estável, abra um Pull Request de `develop` → `main`.

### 5. Hotfix urgente

```bash
git checkout main
git pull origin main
git checkout -b hotfix/descricao-do-problema
```

Após corrigir, abra PR para `main` e, em seguida, replique a correção também em `develop`.

## Regras da branch `main`

- Pull Request obrigatório antes de qualquer merge
- Checks de status devem passar antes do merge (CI/CD)
'@ | Out-File -FilePath CONTRIBUTING.md -Encoding utf8 -NoNewline
