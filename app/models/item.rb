class Item < ApplicationRecord
  belongs_to :uom
  validates :sku, presence: true
  validates :sku, uniqueness: true
end
