json.extract! order_header, :id, :number, :customer_name, :invoice_number, :invoice_date, :state, :created_at, :updated_at
json.url order_header_url(order_header, format: :json)
