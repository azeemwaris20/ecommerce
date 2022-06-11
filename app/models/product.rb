class Product < ApplicationRecord
  SERIAL_NUMBER_RANGE = (100_000..999_999).freeze

  before_destroy :not_referenced_by_any_line_item
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :line_items
  has_many_attached :images

  validates :name, presence: true, length: { maximum: 50 }
  validates :price, presence: true, length: { maximum: 5 }, numericality: { greater_than: 0 }
  validates :quantity, presence: true, length: { maximum: 5 }, numericality: { greater_than: 0 }
  validates :serial_no, presence: true, numericality: { greater_than: 0 }, uniqueness: true
  validates :images, presence: true

  paginates_per 6

  def self.assign_unique_serial_number
    serial_no = loop do
      number = rand(SERIAL_NUMBER_RANGE)
      break number unless Product.exists?(serial_no: number)
    end
    serial_no
  end

  private

  def not_referenced_by_any_line_item
    return if line_items.empty?

    errors.add(:base, 'Line Items Present')
    throw abort
  end
end
