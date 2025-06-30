#!/usr/bin/env ruby

require 'dotenv/load'
require_relative 'lib/vindi_client'
require 'json'

class VindiApp
  def initialize
    @api_key = ENV['VINDI_API_KEY']
    check_api_key
    @client = VindiClient.new(@api_key)
  end

  def run
    puts "🚀 Vindi API Client"
    puts "=" * 30

    loop do
      show_menu
      choice = gets.chomp.to_i

      case choice
      when 1
        test_connection
      when 2
        list_customers
      when 3
        create_customer
      when 4
        list_products
      when 5
        list_plans
      when 6
        list_subscriptions
      when 7
        list_bills
      when 8
        get_merchant_info
      when 9
        list_transactions
      when 10
        list_payment_profiles
      when 11
        list_discounts
      when 12
        list_webhooks
      when 13
        list_charge_attempts
      when 0
        puts "👋 Saindo..."
        break
      else
        puts "❌ Opção inválida!"
      end

      puts "\nPressione Enter para continuar..."
      gets
    end
  end

  private

  def check_api_key
    if @api_key.nil? || @api_key.empty?
      puts "❌ Chave da API não configurada!"
      puts "   Configure a variável VINDI_API_KEY no arquivo .env"
      exit 1
    end
  end

  def show_menu
    puts "\n" + "=" * 40
    puts "Escolha uma opção:"
    puts "1. Testar conexão"
    puts "2. Listar clientes"
    puts "3. Criar cliente"
    puts "4. Listar produtos"
    puts "5. Listar planos"
    puts "6. Listar assinaturas"
    puts "7. Listar faturas"
    puts "8. Informações do merchant"
    puts "9. Listar transações"
    puts "10. Listar perfis de pagamento"
    puts "11. Listar descontos"
    puts "12. Listar webhooks"
    puts "13. Listar tentativas de cobrança"
    puts "0. Sair"
    print "Opção: "
  end

  def test_connection
    puts "\n📡 Testando conexão..."
    result = @client.get_merchant_info

    if result[:success]
      puts "✅ Conexão estabelecida com sucesso!"
      puts "   Merchant: #{result[:data]['merchant']['name']}"
      puts "   Status: #{result[:data]['merchant']['status']}"
    else
      puts "❌ Erro na conexão: #{result[:error]['message']}"
    end
  end

  def list_customers
    puts "\n👥 Listando clientes..."
    print "Quantos clientes exibir? (padrão: 10): "
    limit = gets.chomp
    limit = limit.empty? ? 10 : limit.to_i

    result = @client.list_customers(per_page: limit)

    if result[:success]
      customers = result[:data]['customers']
      puts "✅ #{customers.length} clientes encontrados:"

      customers.each_with_index do |customer, index|
        puts "#{index + 1}. #{customer['name']}"
        puts "   Email: #{customer['email']}"
        puts "   Código: #{customer['code']}"
        puts "   Status: #{customer['status']}"
        puts "   Criado em: #{customer['created_at']}"
        puts ""
      end
    else
      puts "❌ Erro ao listar clientes: #{result[:error]['message']}"
    end
  end

  def create_customer
    puts "\n🆕 Criando novo cliente..."

    print "Nome: "
    name = gets.chomp

    print "Email: "
    email = gets.chomp

    print "CPF/CNPJ: "
    registry_code = gets.chomp

    print "Código do cliente (opcional): "
    code = gets.chomp

    customer_data = {
      name: name,
      email: email,
      registry_code: registry_code
    }

    customer_data[:code] = code unless code.empty?

    result = @client.create_customer(customer_data)

    if result[:success]
      customer = result[:data]['customer']
      puts "✅ Cliente criado com sucesso!"
      puts "   ID: #{customer['id']}"
      puts "   Nome: #{customer['name']}"
      puts "   Email: #{customer['email']}"
    else
      puts "❌ Erro ao criar cliente:"
      if result[:error].is_a?(Hash)
        result[:error]['errors']&.each do |field, messages|
          puts "   #{field}: #{messages.join(', ')}"
        end
      else
        puts "   #{result[:error]}"
      end
    end
  end

  def list_products
    puts "\n📦 Listando produtos..."
    result = @client.list_products(per_page: 10)

    if result[:success]
      products = result[:data]['products']
      puts "✅ #{products.length} produtos encontrados:"

      products.each_with_index do |product, index|
        puts "#{index + 1}. #{product['name']}"
        puts "   Código: #{product['code']}"
        puts "   Status: #{product['status']}"
        puts "   Preço: R$ #{product['pricing_schema']['price']}" if product['pricing_schema']
        puts ""
      end
    else
      puts "❌ Erro ao listar produtos: #{result[:error]['message']}"
    end
  end

  def list_plans
    puts "\n📋 Listando planos..."
    result = @client.list_plans(per_page: 10)

    if result[:success]
      plans = result[:data]['plans']
      puts "✅ #{plans.length} planos encontrados:"

      plans.each_with_index do |plan, index|
        puts "#{index + 1}. #{plan['name']}"
        puts "   Código: #{plan['code']}"
        puts "   Status: #{plan['status']}"
        puts "   Intervalo: #{plan['interval']} #{plan['interval_count']}"
        puts ""
      end
    else
      puts "❌ Erro ao listar planos: #{result[:error]['message']}"
    end
  end

  def list_subscriptions
    puts "\n📄 Listando assinaturas..."
    result = @client.list_subscriptions(per_page: 10)

    if result[:success]
      subscriptions = result[:data]['subscriptions']
      puts "✅ #{subscriptions.length} assinaturas encontradas:"

      subscriptions.each_with_index do |subscription, index|
        puts "#{index + 1}. Assinatura ##{subscription['id']}"
        puts "   Cliente: #{subscription['customer']['name']}"
        puts "   Plano: #{subscription['plan']['name']}"
        puts "   Status: #{subscription['status']}"
        puts "   Criada em: #{subscription['created_at']}"
        puts ""
      end
    else
      puts "❌ Erro ao listar assinaturas: #{result[:error]['message']}"
    end
  end

  def list_bills
    puts "\n🧾 Listando faturas..."
    result = @client.list_bills(per_page: 10)

    if result[:success]
      bills = result[:data]['bills']
      puts "✅ #{bills.length} faturas encontradas:"

      bills.each_with_index do |bill, index|
        puts "#{index + 1}. Fatura ##{bill['id']}"
        puts "   Cliente: #{bill['customer']['name']}"
        puts "   Valor: R$ #{bill['amount']}"
        puts "   Status: #{bill['status']}"
        puts "   Vencimento: #{bill['due_at']}"
        puts ""
      end
    else
      puts "❌ Erro ao listar faturas: #{result[:error]['message']}"
    end
  end

  def get_merchant_info
    puts "\n🏢 Informações do Merchant..."
    result = @client.get_merchant_info

    if result[:success]
      merchant = result[:data]['merchant']
      puts "✅ Informações do merchant:"
      puts "   Nome: #{merchant['name']}"
      puts "   Status: #{merchant['status']}"
      puts "   Código: #{merchant['code']}" if merchant['code']
      puts ""
    else
      puts "❌ Erro ao obter informações: #{result[:error]['message']}"
    end
  end
end

# Executa a aplicação se for chamada diretamente
if __FILE__ == $0
  app = VindiApp.new
  app.run
end
