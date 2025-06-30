#!/usr/bin/env ruby

require 'sinatra'
require 'json'
require 'dotenv/load'
require_relative 'lib/vindi_client'

# Configuração do Sinatra
set :port, 4567
set :bind, '0.0.0.0'
set :environment, :development

# Inicializar o cliente Vindi
configure do
  api_key = ENV['VINDI_API_KEY']
  if api_key.nil? || api_key.empty?
    puts "❌ Chave da API não configurada no arquivo .env"
    exit 1
  end

  set :vindi_client, VindiClient.new(api_key)
end

# Middleware para JSON
before do
  content_type :json
end

# Helper para formatação de resposta
def format_response(result)
  if result[:success]
    status result[:status] || 200
    result[:data].to_json
  else
    status result[:status] || 500
    { error: result[:error] }.to_json
  end
end

# Rota de saúde
get '/health' do
  { status: 'ok', timestamp: Time.now.iso8601 }.to_json
end

# =============================================================================
# CUSTOMERS (Clientes)
# =============================================================================

# Listar clientes
get '/customers' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_customers(page: page, per_page: per_page)
  format_response(result)
end

# Obter cliente específico
get '/customers/:id' do
  result = settings.vindi_client.get_customer(params[:id])
  format_response(result)
end

# Criar cliente
post '/customers' do
  customer_data = JSON.parse(request.body.read)
  result = settings.vindi_client.create_customer(customer_data)
  format_response(result)
end

# Atualizar cliente
put '/customers/:id' do
  customer_data = JSON.parse(request.body.read)
  result = settings.vindi_client.update_customer(params[:id], customer_data)
  format_response(result)
end

# Deletar cliente
delete '/customers/:id' do
  result = settings.vindi_client.delete_customer(params[:id])
  format_response(result)
end

# =============================================================================
# PRODUCTS (Produtos)
# =============================================================================

# Listar produtos
get '/products' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_products(page: page, per_page: per_page)
  format_response(result)
end

# Obter produto específico
get '/products/:id' do
  result = settings.vindi_client.get_product(params[:id])
  format_response(result)
end

# Criar produto
post '/products' do
  product_data = JSON.parse(request.body.read)
  result = settings.vindi_client.create_product(product_data)
  format_response(result)
end

# Atualizar produto
put '/products/:id' do
  product_data = JSON.parse(request.body.read)
  result = settings.vindi_client.update_product(params[:id], product_data)
  format_response(result)
end

# Deletar produto
delete '/products/:id' do
  result = settings.vindi_client.delete_product(params[:id])
  format_response(result)
end

# =============================================================================
# PLANS (Planos)
# =============================================================================

# Listar planos
get '/plans' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_plans(page: page, per_page: per_page)
  format_response(result)
end

# Obter plano específico
get '/plans/:id' do
  result = settings.vindi_client.get_plan(params[:id])
  format_response(result)
end

# Criar plano
post '/plans' do
  plan_data = JSON.parse(request.body.read)
  result = settings.vindi_client.create_plan(plan_data)
  format_response(result)
end

# Atualizar plano
put '/plans/:id' do
  plan_data = JSON.parse(request.body.read)
  result = settings.vindi_client.update_plan(params[:id], plan_data)
  format_response(result)
end

# Deletar plano
delete '/plans/:id' do
  result = settings.vindi_client.delete_plan(params[:id])
  format_response(result)
end

# =============================================================================
# SUBSCRIPTIONS (Assinaturas)
# =============================================================================

# Listar assinaturas
get '/subscriptions' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_subscriptions(page: page, per_page: per_page)
  format_response(result)
end

# Obter assinatura específica
get '/subscriptions/:id' do
  result = settings.vindi_client.get_subscription(params[:id])
  format_response(result)
end

# Criar assinatura
post '/subscriptions' do
  subscription_data = JSON.parse(request.body.read)
  result = settings.vindi_client.create_subscription(subscription_data)
  format_response(result)
end

# Atualizar assinatura
put '/subscriptions/:id' do
  subscription_data = JSON.parse(request.body.read)
  result = settings.vindi_client.update_subscription(params[:id], subscription_data)
  format_response(result)
end

# Cancelar assinatura
delete '/subscriptions/:id' do
  result = settings.vindi_client.cancel_subscription(params[:id])
  format_response(result)
end

# Ativar assinatura
post '/subscriptions/:id/activate' do
  result = settings.vindi_client.activate_subscription(params[:id])
  format_response(result)
end

# Suspender assinatura
post '/subscriptions/:id/suspend' do
  result = settings.vindi_client.suspend_subscription(params[:id])
  format_response(result)
end

# Reativar assinatura
post '/subscriptions/:id/reactivate' do
  result = settings.vindi_client.reactivate_subscription(params[:id])
  format_response(result)
end

# =============================================================================
# BILLS (Faturas)
# =============================================================================

# Listar faturas
get '/bills' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_bills(page: page, per_page: per_page)
  format_response(result)
end

# Obter fatura específica
get '/bills/:id' do
  result = settings.vindi_client.get_bill(params[:id])
  format_response(result)
end

# Criar fatura
post '/bills' do
  bill_data = JSON.parse(request.body.read)
  result = settings.vindi_client.create_bill(bill_data)
  format_response(result)
end

# Aprovar fatura
post '/bills/:id/approve' do
  result = settings.vindi_client.approve_bill(params[:id])
  format_response(result)
end

# Enviar fatura por email
post '/bills/:id/send_email' do
  result = settings.vindi_client.send_bill_by_email(params[:id])
  format_response(result)
end

# Cobrar fatura
post '/bills/:id/charge' do
  result = settings.vindi_client.charge_bill(params[:id])
  format_response(result)
end

# Reemitir fatura
post '/bills/:id/reissue' do
  bill_data = request.body.read.empty? ? {} : JSON.parse(request.body.read)
  result = settings.vindi_client.reissue_bill(params[:id], bill_data)
  format_response(result)
end

# =============================================================================
# CHARGES (Cobranças)
# =============================================================================

# Listar cobranças
get '/charges' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_charges(page: page, per_page: per_page)
  format_response(result)
end

# Obter cobrança específica
get '/charges/:id' do
  result = settings.vindi_client.get_charge(params[:id])
  format_response(result)
end

# Criar cobrança (cartão de crédito)
post '/charges/credit_card' do
  charge_data = JSON.parse(request.body.read)
  result = settings.vindi_client.charge_credit_card(charge_data)
  format_response(result)
end

# Criar cobrança (boleto)
post '/charges/bank_slip' do
  charge_data = JSON.parse(request.body.read)
  result = settings.vindi_client.charge_bank_slip(charge_data)
  format_response(result)
end

# Criar cobrança (cartão de débito)
post '/charges/debit_card' do
  charge_data = JSON.parse(request.body.read)
  result = settings.vindi_client.charge_debit_card(charge_data)
  format_response(result)
end

# Capturar cobrança
post '/charges/:id/capture' do
  result = settings.vindi_client.capture_charge(params[:id])
  format_response(result)
end

# Estornar cobrança
post '/charges/:id/refund' do
  result = settings.vindi_client.refund_charge(params[:id])
  format_response(result)
end

# =============================================================================
# PAYMENT METHODS (Métodos de Pagamento)
# =============================================================================

# Listar métodos de pagamento
get '/payment_methods' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_payment_methods(page: page, per_page: per_page)
  format_response(result)
end

# Obter método de pagamento específico
get '/payment_methods/:id' do
  result = settings.vindi_client.get_payment_method(params[:id])
  format_response(result)
end

# Criar método de pagamento
post '/payment_methods' do
  payment_method_data = JSON.parse(request.body.read)
  result = settings.vindi_client.create_payment_method(payment_method_data)
  format_response(result)
end

# Atualizar método de pagamento
put '/payment_methods/:id' do
  payment_method_data = JSON.parse(request.body.read)
  result = settings.vindi_client.update_payment_method(params[:id], payment_method_data)
  format_response(result)
end

# Deletar método de pagamento
delete '/payment_methods/:id' do
  result = settings.vindi_client.delete_payment_method(params[:id])
  format_response(result)
end

# =============================================================================
# PAYMENT PROFILES (Perfis de Pagamento)
# =============================================================================

# Listar perfis de pagamento
get '/payment_profiles' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_payment_profiles(page: page, per_page: per_page)
  format_response(result)
end

# Obter perfil de pagamento específico
get '/payment_profiles/:id' do
  result = settings.vindi_client.get_payment_profile(params[:id])
  format_response(result)
end

# Criar perfil de pagamento
post '/payment_profiles' do
  payment_profile_data = JSON.parse(request.body.read)
  result = settings.vindi_client.create_payment_profile(payment_profile_data)
  format_response(result)
end

# Atualizar perfil de pagamento
put '/payment_profiles/:id' do
  payment_profile_data = JSON.parse(request.body.read)
  result = settings.vindi_client.update_payment_profile(params[:id], payment_profile_data)
  format_response(result)
end

# Deletar perfil de pagamento
delete '/payment_profiles/:id' do
  result = settings.vindi_client.delete_payment_profile(params[:id])
  format_response(result)
end

# Verificar perfil de pagamento
post '/payment_profiles/:id/verify' do
  result = settings.vindi_client.verify_payment_profile(params[:id])
  format_response(result)
end

# =============================================================================
# WEBHOOKS
# =============================================================================

# Listar webhooks
get '/webhooks' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_webhooks(page: page, per_page: per_page)
  format_response(result)
end

# Obter webhook específico
get '/webhooks/:id' do
  result = settings.vindi_client.get_webhook(params[:id])
  format_response(result)
end

# Criar webhook
post '/webhooks' do
  webhook_data = JSON.parse(request.body.read)
  result = settings.vindi_client.create_webhook(webhook_data)
  format_response(result)
end

# Atualizar webhook
put '/webhooks/:id' do
  webhook_data = JSON.parse(request.body.read)
  result = settings.vindi_client.update_webhook(params[:id], webhook_data)
  format_response(result)
end

# Deletar webhook
delete '/webhooks/:id' do
  result = settings.vindi_client.delete_webhook(params[:id])
  format_response(result)
end

# Testar webhook
post '/webhooks/:id/test' do
  result = settings.vindi_client.test_webhook(params[:id])
  format_response(result)
end

# =============================================================================
# TRANSACTIONS (Transações)
# =============================================================================

# Listar transações
get '/transactions' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_transactions(page: page, per_page: per_page)
  format_response(result)
end

# Obter transação específica
get '/transactions/:id' do
  result = settings.vindi_client.get_transaction(params[:id])
  format_response(result)
end

# =============================================================================
# DISCOUNTS (Descontos)
# =============================================================================

# Listar descontos
get '/discounts' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_discounts(page: page, per_page: per_page)
  format_response(result)
end

# Obter desconto específico
get '/discounts/:id' do
  result = settings.vindi_client.get_discount(params[:id])
  format_response(result)
end

# Criar desconto
post '/discounts' do
  discount_data = JSON.parse(request.body.read)
  result = settings.vindi_client.create_discount(discount_data)
  format_response(result)
end

# Atualizar desconto
put '/discounts/:id' do
  discount_data = JSON.parse(request.body.read)
  result = settings.vindi_client.update_discount(params[:id], discount_data)
  format_response(result)
end

# Deletar desconto
delete '/discounts/:id' do
  result = settings.vindi_client.delete_discount(params[:id])
  format_response(result)
end

# =============================================================================
# MERCHANT
# =============================================================================

# Obter informações do merchant
get '/merchant' do
  result = settings.vindi_client.get_merchant_info
  format_response(result)
end

# Atualizar merchant
put '/merchant' do
  merchant_data = JSON.parse(request.body.read)
  result = settings.vindi_client.update_merchant(merchant_data)
  format_response(result)
end

# =============================================================================
# OUTROS ENDPOINTS
# =============================================================================

# Listar issues
get '/issues' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_issues(page: page, per_page: per_page)
  format_response(result)
end

# Listar mensagens
get '/messages' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_messages(page: page, per_page: per_page)
  format_response(result)
end

# Listar notificações
get '/notifications' do
  page = params[:page]&.to_i || 1
  per_page = params[:per_page]&.to_i || 25

  result = settings.vindi_client.list_notifications(page: page, per_page: per_page)
  format_response(result)
end

# Inicializar servidor
if __FILE__ == $0
  puts "🚀 Vindi API Proxy iniciada"
  puts "📡 Conectando com: #{ENV['VINDI_API_KEY'] ? 'API configurada' : 'API NÃO configurada'}"
  puts "🌐 Servidor rodando em: http://localhost:4567"
  puts "🏥 Health check: http://localhost:4567/health"
  puts "=" * 50
end
