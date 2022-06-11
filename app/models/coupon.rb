class Coupon < ApplicationRecord
  validates :name, presence: true, allow_blank: false, length: { in: 4..10 },
                   uniqueness: true, format: { with: /([A-Z]+[0-9]*)/ }
  validates :discount, presence: true, numericality: { greater_than: 0, less_than: 100 }
  validates :valid_til, presence: true, date: { after: proc { Date.today }, message: 'must be after today' }
end
