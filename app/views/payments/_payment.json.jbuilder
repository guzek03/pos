json.extract! payment, :id, :code, :name, :state, :created_at, :updated_at
json.url payment_url(payment, format: :json)
