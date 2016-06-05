# Our representation of a stockfighter order placement
class Order < ApplicationRecord
  validates :account, presence: true
  validates :direction, inclusion: { in: %w(buy sell) }, presence: true
  validates :order_type, inclusion: { in: %w(fill-or-kill immediate-or-cancel limit market) }, presence: true
  validates :price, numericality: { greater_than: 0, only_integer: true }, presence: true
  validates :quantity, numericality: { greater_than: 0, only_integer: true }, presence: true
  validates :symbol, presence: true
  validates :venue, presence: true
end
