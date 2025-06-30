require 'rest-client'
require 'json'
require 'uri'

class VindiClient
  BASE_URL = 'http://app.vindi.local:3000/api/v1'

  def initialize(api_key)
    @api_key = api_key
    @headers = {
      'Content-Type' => 'application/json',
      'User-Agent' => 'Ruby Vindi Client/1.0'
    }
  end

  # Customers (Clientes)
  def list_customers(page: 1, per_page: 25)
    get_request('/customers', { page: page, per_page: per_page })
  end

  def get_customer(customer_id)
    get_request("/customers/#{customer_id}")
  end

  def create_customer(customer_data)
    post_request('/customers', customer_data)
  end

  def update_customer(customer_id, customer_data)
    put_request("/customers/#{customer_id}", customer_data)
  end

  def delete_customer(customer_id)
    delete_request("/customers/#{customer_id}")
  end

  # Plans (Planos)
  def list_plans(page: 1, per_page: 25)
    get_request('/plans', { page: page, per_page: per_page })
  end

  def get_plan(plan_id)
    get_request("/plans/#{plan_id}")
  end

  def create_plan(plan_data)
    post_request('/plans', plan_data)
  end

  def update_plan(plan_id, plan_data)
    put_request("/plans/#{plan_id}", plan_data)
  end

  def delete_plan(plan_id)
    delete_request("/plans/#{plan_id}")
  end

  # Products (Produtos)
  def list_products(page: 1, per_page: 25)
    get_request('/products', { page: page, per_page: per_page })
  end

  def get_product(product_id)
    get_request("/products/#{product_id}")
  end

  def create_product(product_data)
    post_request('/products', product_data)
  end

  def update_product(product_id, product_data)
    put_request("/products/#{product_id}", product_data)
  end

  def delete_product(product_id)
    delete_request("/products/#{product_id}")
  end

  # Subscriptions (Assinaturas)
  def list_subscriptions(page: 1, per_page: 25)
    get_request('/subscriptions', { page: page, per_page: per_page })
  end

  def get_subscription(subscription_id)
    get_request("/subscriptions/#{subscription_id}")
  end

  def create_subscription(subscription_data)
    post_request('/subscriptions', subscription_data)
  end

  def update_subscription(subscription_id, subscription_data)
    put_request("/subscriptions/#{subscription_id}", subscription_data)
  end

  def cancel_subscription(subscription_id)
    delete_request("/subscriptions/#{subscription_id}")
  end

  # Bills (Faturas)
  def list_bills(page: 1, per_page: 25)
    get_request('/bills', { page: page, per_page: per_page })
  end

  def get_bill(bill_id)
    get_request("/bills/#{bill_id}")
  end

  def create_bill(bill_data)
    post_request('/bills', bill_data)
  end

  # Payment Methods (Métodos de Pagamento)
  def list_payment_methods(page: 1, per_page: 25)
    get_request('/payment_methods', { page: page, per_page: per_page })
  end

  def get_payment_method(payment_method_id)
    get_request("/payment_methods/#{payment_method_id}")
  end

  def create_payment_method(payment_method_data)
    post_request('/payment_methods', payment_method_data)
  end

  def update_payment_method(payment_method_id, payment_method_data)
    put_request("/payment_methods/#{payment_method_id}", payment_method_data)
  end

  def delete_payment_method(payment_method_id)
    delete_request("/payment_methods/#{payment_method_id}")
  end

  # Charges (Cobranças)
  def list_charges(page: 1, per_page: 25)
    get_request('/charges', { page: page, per_page: per_page })
  end

  def get_charge(charge_id)
    get_request("/charges/#{charge_id}")
  end

  def charge_credit_card(charge_data)
    post_request('/charges', charge_data)
  end

  # Webhooks
  def list_webhooks(page: 1, per_page: 25)
    get_request('/webhooks', { page: page, per_page: per_page })
  end

  def create_webhook(webhook_data)
    post_request('/webhooks', webhook_data)
  end

  # Merchant
  def get_merchant_info
    get_request('/merchant')
  end

  def update_merchant(merchant_data)
    put_request('/merchant', merchant_data)
  end

  # Transactions (Transações)
  def list_transactions(page: 1, per_page: 25)
    get_request('/transactions', { page: page, per_page: per_page })
  end

  def get_transaction(transaction_id)
    get_request("/transactions/#{transaction_id}")
  end

  # Payment Profiles (Perfis de Pagamento)
  def list_payment_profiles(page: 1, per_page: 25)
    get_request('/payment_profiles', { page: page, per_page: per_page })
  end

  def get_payment_profile(payment_profile_id)
    get_request("/payment_profiles/#{payment_profile_id}")
  end

  def create_payment_profile(payment_profile_data)
    post_request('/payment_profiles', payment_profile_data)
  end

  def update_payment_profile(payment_profile_id, payment_profile_data)
    put_request("/payment_profiles/#{payment_profile_id}", payment_profile_data)
  end

  def delete_payment_profile(payment_profile_id)
    delete_request("/payment_profiles/#{payment_profile_id}")
  end

  def verify_payment_profile(payment_profile_id)
    post_request("/payment_profiles/#{payment_profile_id}/verify", {})
  end

  # Discounts (Descontos)
  def list_discounts(page: 1, per_page: 25)
    get_request('/discounts', { page: page, per_page: per_page })
  end

  def get_discount(discount_id)
    get_request("/discounts/#{discount_id}")
  end

  def create_discount(discount_data)
    post_request('/discounts', discount_data)
  end

  def update_discount(discount_id, discount_data)
    put_request("/discounts/#{discount_id}", discount_data)
  end

  def delete_discount(discount_id)
    delete_request("/discounts/#{discount_id}")
  end

  # Product Items (Itens de Produto)
  def list_product_items(page: 1, per_page: 25)
    get_request('/product_items', { page: page, per_page: per_page })
  end

  def get_product_item(product_item_id)
    get_request("/product_items/#{product_item_id}")
  end

  def create_product_item(product_item_data)
    post_request('/product_items', product_item_data)
  end

  def update_product_item(product_item_id, product_item_data)
    put_request("/product_items/#{product_item_id}", product_item_data)
  end

  def delete_product_item(product_item_id)
    delete_request("/product_items/#{product_item_id}")
  end

  # Periods (Períodos)
  def list_periods(page: 1, per_page: 25)
    get_request('/periods', { page: page, per_page: per_page })
  end

  def get_period(period_id)
    get_request("/periods/#{period_id}")
  end

  def update_period(period_id, period_data)
    put_request("/periods/#{period_id}", period_data)
  end

  # Usages (Usos/Medições)
  def list_usages(page: 1, per_page: 25)
    get_request('/usages', { page: page, per_page: per_page })
  end

  def get_usage(usage_id)
    get_request("/usages/#{usage_id}")
  end

  def create_usage(usage_data)
    post_request('/usages', usage_data)
  end

  def update_usage(usage_id, usage_data)
    put_request("/usages/#{usage_id}", usage_data)
  end

  def delete_usage(usage_id)
    delete_request("/usages/#{usage_id}")
  end

  # Issues (Problemas/Pendências)
  def list_issues(page: 1, per_page: 25)
    get_request('/issues', { page: page, per_page: per_page })
  end

  def get_issue(issue_id)
    get_request("/issues/#{issue_id}")
  end

  # Messages (Mensagens)
  def list_messages(page: 1, per_page: 25)
    get_request('/messages', { page: page, per_page: per_page })
  end

  def get_message(message_id)
    get_request("/messages/#{message_id}")
  end

  # Imports (Importações)
  def list_imports(page: 1, per_page: 25)
    get_request('/imports', { page: page, per_page: per_page })
  end

  def get_import(import_id)
    get_request("/imports/#{import_id}")
  end

  def create_import(import_data)
    post_request('/imports', import_data)
  end

  # Notifications (Notificações)
  def list_notifications(page: 1, per_page: 25)
    get_request('/notifications', { page: page, per_page: per_page })
  end

  def get_notification(notification_id)
    get_request("/notifications/#{notification_id}")
  end

  # Partner Applications (Aplicações Parceiras)
  def list_partner_applications(page: 1, per_page: 25)
    get_request('/partner_applications', { page: page, per_page: per_page })
  end

  def get_partner_application(partner_application_id)
    get_request("/partner_applications/#{partner_application_id}")
  end

  # Subscription Schedules (Agendamentos de Assinatura)
  def list_subscription_schedules(page: 1, per_page: 25)
    get_request('/subscription_schedules', { page: page, per_page: per_page })
  end

  def get_subscription_schedule(subscription_schedule_id)
    get_request("/subscription_schedules/#{subscription_schedule_id}")
  end

  def create_subscription_schedule(subscription_schedule_data)
    post_request('/subscription_schedules', subscription_schedule_data)
  end

  def update_subscription_schedule(subscription_schedule_id, subscription_schedule_data)
    put_request("/subscription_schedules/#{subscription_schedule_id}", subscription_schedule_data)
  end

  def delete_subscription_schedule(subscription_schedule_id)
    delete_request("/subscription_schedules/#{subscription_schedule_id}")
  end

  # Bill Items (Itens de Fatura)
  def list_bill_items(page: 1, per_page: 25)
    get_request('/bill_items', { page: page, per_page: per_page })
  end

  def get_bill_item(bill_item_id)
    get_request("/bill_items/#{bill_item_id}")
  end

  # Charge Attempts (Tentativas de Cobrança)
  def list_charge_attempts(page: 1, per_page: 25)
    get_request('/charge_attempts', { page: page, per_page: per_page })
  end

  def get_charge_attempt(charge_attempt_id)
    get_request("/charge_attempts/#{charge_attempt_id}")
  end

  # Payment Companies (Empresas de Pagamento)
  def list_payment_companies(page: 1, per_page: 25)
    get_request('/payment_companies', { page: page, per_page: per_page })
  end

  def get_payment_company(payment_company_id)
    get_request("/payment_companies/#{payment_company_id}")
  end

  # Payment Conditions (Condições de Pagamento)
  def list_payment_conditions(page: 1, per_page: 25)
    get_request('/payment_conditions', { page: page, per_page: per_page })
  end

  def get_payment_condition(payment_condition_id)
    get_request("/payment_conditions/#{payment_condition_id}")
  end

  # Ações específicas para Bills (Faturas)
  def approve_bill(bill_id)
    post_request("/bills/#{bill_id}/approve", {})
  end

  def send_bill_by_email(bill_id)
    post_request("/bills/#{bill_id}/send_by_email", {})
  end

  def charge_bill(bill_id)
    post_request("/bills/#{bill_id}/charge", {})
  end

  def reissue_bill(bill_id, bill_data = {})
    post_request("/bills/#{bill_id}/reissue", bill_data)
  end

  # Ações específicas para Charges (Cobranças)
  def charge_bank_slip(charge_data)
    post_request('/charges', charge_data.merge({ payment_method_code: 'bank_slip' }))
  end

  def charge_debit_card(charge_data)
    post_request('/charges', charge_data.merge({ payment_method_code: 'debit_card' }))
  end

  def fraud_review_charge(charge_id)
    post_request("/charges/#{charge_id}/fraud_review", {})
  end

  def refund_charge(charge_id)
    post_request("/charges/#{charge_id}/refund", {})
  end

  def capture_charge(charge_id)
    post_request("/charges/#{charge_id}/capture", {})
  end

  # Ações específicas para Subscriptions (Assinaturas)
  def activate_subscription(subscription_id)
    post_request("/subscriptions/#{subscription_id}/activate", {})
  end

  def suspend_subscription(subscription_id)
    post_request("/subscriptions/#{subscription_id}/suspend", {})
  end

  def reactivate_subscription(subscription_id)
    post_request("/subscriptions/#{subscription_id}/reactivate", {})
  end

  # Webhooks adicionais
  def get_webhook(webhook_id)
    get_request("/webhooks/#{webhook_id}")
  end

  def update_webhook(webhook_id, webhook_data)
    put_request("/webhooks/#{webhook_id}", webhook_data)
  end

  def delete_webhook(webhook_id)
    delete_request("/webhooks/#{webhook_id}")
  end

  def test_webhook(webhook_id)
    post_request("/webhooks/#{webhook_id}/test", {})
  end

  private

  def get_request(endpoint, params = {})
    url = build_url(endpoint, params)

    begin
      response = RestClient::Request.execute(
        method: :get,
        url: url,
        headers: @headers,
        user: @api_key,
        password: '',
        timeout: 30
      )
      parse_response(response)
    rescue RestClient::ExceptionWithResponse => e
      handle_error(e)
    rescue RestClient::Exception => e
      handle_connection_error(e)
    end
  end

  def post_request(endpoint, data)
    begin
      response = RestClient::Request.execute(
        method: :post,
        url: "#{BASE_URL}#{endpoint}",
        payload: data.to_json,
        headers: @headers,
        user: @api_key,
        password: '',
        timeout: 30
      )
      parse_response(response)
    rescue RestClient::ExceptionWithResponse => e
      handle_error(e)
    rescue RestClient::Exception => e
      handle_connection_error(e)
    end
  end

  def put_request(endpoint, data)
    begin
      response = RestClient::Request.execute(
        method: :put,
        url: "#{BASE_URL}#{endpoint}",
        payload: data.to_json,
        headers: @headers,
        user: @api_key,
        password: '',
        timeout: 30
      )
      parse_response(response)
    rescue RestClient::ExceptionWithResponse => e
      handle_error(e)
    rescue RestClient::Exception => e
      handle_connection_error(e)
    end
  end

  def delete_request(endpoint)
    begin
      response = RestClient::Request.execute(
        method: :delete,
        url: "#{BASE_URL}#{endpoint}",
        headers: @headers,
        user: @api_key,
        password: '',
        timeout: 30
      )
      parse_response(response)
    rescue RestClient::ExceptionWithResponse => e
      handle_error(e)
    rescue RestClient::Exception => e
      handle_connection_error(e)
    end
  end

  def build_url(endpoint, params = {})
    url = "#{BASE_URL}#{endpoint}"
    url += "?#{URI.encode_www_form(params)}" unless params.empty?
    url
  end

  def parse_response(response)
    return { success: true, data: nil } if response.body.empty?

    parsed_response = JSON.parse(response.body)
    { success: true, data: parsed_response, status: response.code }
  rescue JSON::ParserError
    { success: false, error: 'Invalid JSON response', status: response.code }
  end

  def handle_error(exception)
    error_response = begin
      JSON.parse(exception.response.body) if exception.response
    rescue JSON::ParserError
      nil
    end

    {
      success: false,
      error: error_response || { message: exception.message },
      status: exception.response&.code
    }
  end

  def handle_connection_error(exception)
    {
      success: false,
      error: { message: "Connection error: #{exception.message}" },
      status: nil
    }
  end
end
