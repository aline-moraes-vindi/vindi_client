# Vindi API Proxy Server

Uma API REST que atua como proxy/wrapper para a [API da Vindi](https://vindi.github.io/api-docs/dist/?url=https://sandbox-app.vindi.com.br/api/v1/docs#/), permitindo consumir todos os endpoints da Vindi através de uma interface HTTP simples.

## 🚀 Iniciando

### Configuração

1. **Instale as dependências:**
```bash
bundle install
```

2. **Configure sua chave da API:**
O arquivo `.env` já deve existir com sua chave da API da Vindi.

### Executando a API

```bash
bundle exec ruby api.rb
```

A API ficará disponível em: `http://localhost:4567`

## 📋 Endpoints Disponíveis

### 🏥 Health Check
```http
GET /health
```

### 👥 Customers (Clientes)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/customers` | Listar clientes |
| `GET` | `/customers/:id` | Obter cliente específico |
| `POST` | `/customers` | Criar cliente |
| `PUT` | `/customers/:id` | Atualizar cliente |
| `DELETE` | `/customers/:id` | Deletar cliente |

**Exemplo - Criar Cliente:**
```bash
curl -X POST http://localhost:4567/customers \
  -H "Content-Type: application/json" \
  -d '{
    "name": "João Silva",
    "email": "joao@exemplo.com",
    "registry_code": "12345678901"
  }'
```

### 📦 Products (Produtos)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/products` | Listar produtos |
| `GET` | `/products/:id` | Obter produto específico |
| `POST` | `/products` | Criar produto |
| `PUT` | `/products/:id` | Atualizar produto |
| `DELETE` | `/products/:id` | Deletar produto |

**Exemplo - Listar Produtos:**
```bash
curl http://localhost:4567/products?page=1&per_page=10
```

### 📋 Plans (Planos)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/plans` | Listar planos |
| `GET` | `/plans/:id` | Obter plano específico |
| `POST` | `/plans` | Criar plano |
| `PUT` | `/plans/:id` | Atualizar plano |
| `DELETE` | `/plans/:id` | Deletar plano |

**Exemplo - Criar Plano:**
```bash
curl -X POST http://localhost:4567/plans \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Plano Mensal",
    "interval": "months",
    "interval_count": 1,
    "billing_trigger_type": "beginning_of_period",
    "billing_trigger_day": 1,
    "plan_items": [
      {
        "product_id": 1,
        "quantity": 1
      }
    ]
  }'
```

### 📄 Subscriptions (Assinaturas)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/subscriptions` | Listar assinaturas |
| `GET` | `/subscriptions/:id` | Obter assinatura específica |
| `POST` | `/subscriptions` | Criar assinatura |
| `PUT` | `/subscriptions/:id` | Atualizar assinatura |
| `DELETE` | `/subscriptions/:id` | Cancelar assinatura |
| `POST` | `/subscriptions/:id/activate` | Ativar assinatura |
| `POST` | `/subscriptions/:id/suspend` | Suspender assinatura |
| `POST` | `/subscriptions/:id/reactivate` | Reativar assinatura |

**Exemplo - Criar Assinatura:**
```bash
curl -X POST http://localhost:4567/subscriptions \
  -H "Content-Type: application/json" \
  -d '{
    "plan_id": 1,
    "customer_id": 1,
    "payment_method_code": "credit_card"
  }'
```

### 🧾 Bills (Faturas)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/bills` | Listar faturas |
| `GET` | `/bills/:id` | Obter fatura específica |
| `POST` | `/bills/:id/approve` | Aprovar fatura |
| `POST` | `/bills/:id/send_email` | Enviar fatura por email |
| `POST` | `/bills/:id/charge` | Cobrar fatura |
| `POST` | `/bills/:id/reissue` | Reemitir fatura |

**Exemplo - Aprovar Fatura:**
```bash
curl -X POST http://localhost:4567/bills/123/approve
```

### 💳 Charges (Cobranças)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/charges` | Listar cobranças |
| `GET` | `/charges/:id` | Obter cobrança específica |
| `POST` | `/charges/credit_card` | Criar cobrança (cartão de crédito) |
| `POST` | `/charges/bank_slip` | Criar cobrança (boleto) |
| `POST` | `/charges/debit_card` | Criar cobrança (cartão de débito) |
| `POST` | `/charges/:id/capture` | Capturar cobrança |
| `POST` | `/charges/:id/refund` | Estornar cobrança |

**Exemplo - Cobrança com Cartão:**
```bash
curl -X POST http://localhost:4567/charges/credit_card \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 100.00,
    "payment_method_code": "credit_card",
    "bill_id": 123
  }'
```

### 💰 Payment Methods (Métodos de Pagamento)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/payment_methods` | Listar métodos de pagamento |
| `GET` | `/payment_methods/:id` | Obter método específico |
| `POST` | `/payment_methods` | Criar método de pagamento |
| `PUT` | `/payment_methods/:id` | Atualizar método |
| `DELETE` | `/payment_methods/:id` | Deletar método |

### 👤 Payment Profiles (Perfis de Pagamento)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/payment_profiles` | Listar perfis de pagamento |
| `GET` | `/payment_profiles/:id` | Obter perfil específico |
| `POST` | `/payment_profiles` | Criar perfil de pagamento |
| `PUT` | `/payment_profiles/:id` | Atualizar perfil |
| `DELETE` | `/payment_profiles/:id` | Deletar perfil |
| `POST` | `/payment_profiles/:id/verify` | Verificar perfil |

### 🔗 Webhooks

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/webhooks` | Listar webhooks |
| `GET` | `/webhooks/:id` | Obter webhook específico |
| `POST` | `/webhooks` | Criar webhook |
| `PUT` | `/webhooks/:id` | Atualizar webhook |
| `DELETE` | `/webhooks/:id` | Deletar webhook |
| `POST` | `/webhooks/:id/test` | Testar webhook |

**Exemplo - Criar Webhook:**
```bash
curl -X POST http://localhost:4567/webhooks \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://meusite.com/webhook",
    "events": ["bill_created", "charge_created"]
  }'
```

### 🏢 Merchant

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/merchant` | Obter informações do merchant |
| `PUT` | `/merchant` | Atualizar merchant |

### 💸 Transactions (Transações)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/transactions` | Listar transações |
| `GET` | `/transactions/:id` | Obter transação específica |

### 🎯 Discounts (Descontos)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/discounts` | Listar descontos |
| `GET` | `/discounts/:id` | Obter desconto específico |
| `POST` | `/discounts` | Criar desconto |
| `PUT` | `/discounts/:id` | Atualizar desconto |
| `DELETE` | `/discounts/:id` | Deletar desconto |

### 📊 Outros Endpoints

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/issues` | Listar problemas/pendências |
| `GET` | `/messages` | Listar mensagens |
| `GET` | `/notifications` | Listar notificações |

## 📝 Parâmetros de Paginação

Todos os endpoints de listagem suportam paginação:

- `page`: Número da página (padrão: 1)
- `per_page`: Items por página (padrão: 25)

**Exemplo:**
```bash
curl "http://localhost:4567/customers?page=2&per_page=10"
```

## 🔧 Formato das Respostas

### Sucesso (200)
```json
{
  "customers": [
    {
      "id": 1,
      "name": "João Silva",
      "email": "joao@exemplo.com"
    }
  ]
}
```

### Erro (4xx/5xx)
```json
{
  "error": {
    "message": "Descrição do erro"
  }
}
```

## 🧪 Testando a API

### Health Check
```bash
curl http://localhost:4567/health
```

### Listar Clientes
```bash
curl http://localhost:4567/customers
```

### Obter Informações do Merchant
```bash
curl http://localhost:4567/merchant
```

## 🛠️ Desenvolvimento

Para modificar ou adicionar novos endpoints:

1. Edite o arquivo `api.rb`
2. Adicione novos métodos no `lib/vindi_client.rb` se necessário
3. Reinicie o servidor

## 📚 Documentação da API Vindi

Para mais detalhes sobre os dados esperados em cada endpoint, consulte:
- [Documentação Oficial da API Vindi](https://vindi.github.io/api-docs/dist/?url=https://sandbox-app.vindi.com.br/api/v1/docs#/)

## 🚀 Deploy

Para usar em produção:

1. Configure as variáveis de ambiente adequadamente
2. Use um servidor web como Puma ou Unicorn
3. Configure um proxy reverso (nginx)
4. Considere usar HTTPS

**Exemplo com Puma:**
```bash
gem install puma
puma -p 4567 api.rb
```
