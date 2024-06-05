class Item < ApplicationRecord
  belongs_to :uom
  validates :sku, presence: true
  validates :sku, uniqueness: true

  def sku_name
    "#{self.sku} - #{self.name}"
  end
end
