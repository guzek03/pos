class OrderHeader < ApplicationRecord
  has_many :order_details
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true
end
