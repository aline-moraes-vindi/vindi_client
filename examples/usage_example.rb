#!/usr/bin/env ruby

require 'dotenv/load'
require_relative '../lib/vindi_client'

# Carrega a chave da API do arquivo .env ou variável de ambiente
API_KEY = ENV['VINDI_API_KEY'] || 'sua_chave_da_api_aqui'

if API_KEY == 'sua_chave_da_api_aqui' || API_KEY.nil? || API_KEY.empty?
  puts "⚠️  Por favor, configure sua chave da API da Vindi:"
  puts "   - Crie um arquivo .env na raiz do projeto com: VINDI_API_KEY=sua_chave"
  puts "   - Ou defina a variável de ambiente VINDI_API_KEY"
  puts "   - Use a chave da API do ambiente sandbox da Vindi"
  exit 1
end

# Inicializa o cliente
client = VindiClient.new(API_KEY)

puts "🚀 Vindi API Client - Exemplo de Uso"
puts "=" * 50

# 1. Teste de conexão
puts "\n📡 Testando conexão com a API..."
merchant_info = client.get_merchant_info
if merchant_info[:success]
  puts "✅ Conexão estabelecida com sucesso!"
  puts "   Merchant: #{merchant_info[:data]['merchant']['name']}"
else
  puts "❌ Erro na conexão: #{merchant_info[:error]['message']}"
  exit 1
end

# 2. Listar clientes
puts "\n👥 Listando clientes..."
customers = client.list_customers(per_page: 5)
if customers[:success]
  puts "✅ Clientes encontrados: #{customers[:data]['customers'].length}"
  customers[:data]['customers'].each do |customer|
    puts "   - #{customer['name']} (#{customer['email']})"
  end
else
  puts "❌ Erro ao listar clientes: #{customers[:error]['message']}"
end

# 3. Listar produtos
puts "\n📦 Listando produtos..."
products = client.list_products(per_page: 5)
if products[:success]
  puts "✅ Produtos encontrados: #{products[:data]['products'].length}"
  products[:data]['products'].each do |product|
    puts "   - #{product['name']} (#{product['code']})"
  end
else
  puts "❌ Erro ao listar produtos: #{products[:error]['message']}"
end

# 4. Listar planos
puts "\n📋 Listando planos..."
plans = client.list_plans(per_page: 5)
if plans[:success]
  puts "✅ Planos encontrados: #{plans[:data]['plans'].length}"
  plans[:data]['plans'].each do |plan|
    puts "   - #{plan['name']} (#{plan['code']})"
  end
else
  puts "❌ Erro ao listar planos: #{plans[:error]['message']}"
end

# 5. Listar assinaturas
puts "\n📄 Listando assinaturas..."
subscriptions = client.list_subscriptions(per_page: 5)
if subscriptions[:success]
  puts "✅ Assinaturas encontradas: #{subscriptions[:data]['subscriptions'].length}"
  subscriptions[:data]['subscriptions'].each do |subscription|
    puts "   - Assinatura ##{subscription['id']} - Status: #{subscription['status']}"
  end
else
  puts "❌ Erro ao listar assinaturas: #{subscriptions[:error]['message']}"
end

# 6. Listar faturas
puts "\n🧾 Listando faturas..."
bills = client.list_bills(per_page: 5)
if bills[:success]
  puts "✅ Faturas encontradas: #{bills[:data]['bills'].length}"
  bills[:data]['bills'].each do |bill|
    puts "   - Fatura ##{bill['id']} - Status: #{bill['status']} - Valor: R$ #{bill['amount']}"
  end
else
  puts "❌ Erro ao listar faturas: #{bills[:error]['message']}"
end

# 7. Exemplo de criação de cliente (comentado para não criar dados desnecessários)
puts "\n🆕 Exemplo de criação de cliente (simulado)..."
puts "   Para criar um cliente real, descomente o código abaixo:"
puts <<~RUBY
   new_customer_data = {
     name: "João Silva",
     email: "joao.silva@exemplo.com",
     registry_code: "12345678901",
     code: "cliente_001"
   }

   result = client.create_customer(new_customer_data)
   if result[:success]
     puts "✅ Cliente criado com sucesso!"
     puts "   ID: \#{result[:data]['customer']['id']}"
   else
     puts "❌ Erro ao criar cliente: \#{result[:error]['message']}"
   end
RUBY

puts "\n✨ Exemplo executado com sucesso!"
puts "   Consulte a documentação da API em: https://vindi.github.io/api-docs/"
