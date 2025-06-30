# Vindi API Client

Uma mini aplicação Ruby para consumir a API da Vindi de forma simples e intuitiva.

## 📋 Sobre

Esta aplicação foi desenvolvida para demonstrar a integração com a [API da Vindi](https://vindi.github.io/api-docs/dist/?url=https://sandbox-app.vindi.com.br/api/v1/docs#/), uma plataforma de pagamentos recorrentes.

A aplicação inclui:
- Cliente Ruby para consumir a API da Vindi
- Interface de linha de comando interativa
- Exemplos de uso prático
- Tratamento de erros robusto

## 🚀 Funcionalidades

- ✅ **Clientes**: Listar, criar, atualizar e excluir clientes
- ✅ **Produtos**: Gerenciar produtos e seus preços
- ✅ **Planos**: Configurar planos de assinatura
- ✅ **Assinaturas**: Gerenciar assinaturas de clientes
- ✅ **Faturas**: Visualizar faturas geradas
- ✅ **Métodos de Pagamento**: Gerenciar formas de pagamento
- ✅ **Cobranças**: Processar cobranças
- ✅ **Webhooks**: Configurar webhooks
- ✅ **Merchant**: Obter informações da conta

## 📦 Instalação

### Pré-requisitos

- Ruby 2.7 ou superior
- Bundler gem

### Passos para instalação

1. **Clone ou baixe o projeto**
```bash
cd vindi_api_client
```

2. **Instale as dependências**
```bash
bundle install
```

3. **Configure sua chave da API**

Crie um arquivo `.env` na raiz do projeto:
```bash
# .env
VINDI_API_KEY=sua_chave_da_api_aqui
```

**Como obter sua chave da API:**
- Acesse: https://sandbox-app.vindi.com.br/admin/api_keys
- Faça login em sua conta sandbox da Vindi
- Gere uma nova chave da API
- Use sempre o ambiente **sandbox** para testes

## 🎯 Como Usar

### Opção 1: Interface Interativa

Execute a aplicação principal:
```bash
ruby app.rb
```

Isso abrirá um menu interativo onde você pode:
- Testar a conexão
- Listar e criar clientes
- Visualizar produtos, planos, assinaturas e faturas
- Obter informações do merchant

### Opção 2: Exemplo de Uso

Execute o arquivo de exemplo:
```bash
ruby examples/usage_example.rb
```

### Opção 3: Usar como Biblioteca

```ruby
require_relative 'lib/vindi_client'

# Inicializar o cliente
client = VindiClient.new('sua_chave_da_api')

# Testar conexão
info = client.get_merchant_info
puts info[:data]['merchant']['name'] if info[:success]

# Listar clientes
customers = client.list_customers(per_page: 10)
customers[:data]['customers'].each do |customer|
  puts "#{customer['name']} - #{customer['email']}"
end if customers[:success]

# Criar um novo cliente
new_customer = {
  name: "João Silva",
  email: "joao@exemplo.com",
  registry_code: "12345678901"
}

result = client.create_customer(new_customer)
puts "Cliente criado: #{result[:data]['customer']['id']}" if result[:success]
```

## 📚 Documentação da API

Para mais informações sobre os endpoints disponíveis, consulte:
- [Documentação Oficial da API Vindi](https://vindi.github.io/api-docs/dist/?url=https://sandbox-app.vindi.com.br/api/v1/docs#/)
- [Portal do Desenvolvedor Vindi](https://developer.vindi.com.br/)

## 🔧 Estrutura do Projeto

```
vindi_api_client/
├── lib/
│   └── vindi_client.rb      # Cliente principal da API
├── examples/
│   └── usage_example.rb     # Exemplo de uso
├── app.rb                   # Aplicação principal (CLI)
├── Gemfile                  # Dependências Ruby
└── README.md               # Este arquivo
```

## 📋 Métodos Disponíveis

### Clientes
- `list_customers(page: 1, per_page: 25)`
- `get_customer(customer_id)`
- `create_customer(customer_data)`
- `update_customer(customer_id, customer_data)`
- `delete_customer(customer_id)`

### Produtos
- `list_products(page: 1, per_page: 25)`
- `get_product(product_id)`
- `create_product(product_data)`
- `update_product(product_id, product_data)`
- `delete_product(product_id)`

### Planos
- `list_plans(page: 1, per_page: 25)`
- `get_plan(plan_id)`
- `create_plan(plan_data)`
- `update_plan(plan_id, plan_data)`
- `delete_plan(plan_id)`

### Assinaturas
- `list_subscriptions(page: 1, per_page: 25)`
- `get_subscription(subscription_id)`
- `create_subscription(subscription_data)`
- `update_subscription(subscription_id, subscription_data)`
- `cancel_subscription(subscription_id)`

### Outros
- `list_bills(page: 1, per_page: 25)`
- `list_payment_methods(page: 1, per_page: 25)`
- `list_charges(page: 1, per_page: 25)`
- `get_merchant_info()`

## 🔒 Segurança

- ⚠️ **Nunca** commit sua chave da API no controle de versão
- Use sempre o ambiente **sandbox** para desenvolvimento e testes
- Mantenha suas chaves da API seguras e privadas
- Use variáveis de ambiente para configurações sensíveis

## 🐛 Tratamento de Erros

A aplicação trata os seguintes tipos de erro:
- Erros de conexão de rede
- Respostas da API com erro (4xx, 5xx)
- JSON inválido
- Timeouts de requisição

Exemplo de resposta com erro:
```ruby
{
  success: false,
  error: { message: "Mensagem do erro" },
  status: 400
}
```

## 🤝 Contribuindo

Este é um projeto de exemplo e demonstração. Para melhorias:

1. Faça um fork do projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Abra um Pull Request

## 📄 Licença

Este projeto é apenas para fins educacionais e de demonstração.

## 📞 Suporte

- [Documentação da Vindi](https://developer.vindi.com.br/)
- [Suporte Vindi](https://atendimento.vindi.com.br/)

---

**Nota**: Esta aplicação foi criada para demonstrar a integração com a API da Vindi. Use sempre o ambiente sandbox para testes e desenvolvimento.
