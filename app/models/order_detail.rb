class OrderDetail < ApplicationRecord
  belongs_to :order_header
  belongs_to :item
end
