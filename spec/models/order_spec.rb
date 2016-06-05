require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should respond_to :account }
  it { should validate_presence_of :account }

  it { should respond_to :direction }
  it { should validate_inclusion_of(:direction).in_array %w(buy sell) }

  it { should respond_to :order_type }
  it { should validate_inclusion_of(:order_type).in_array %w(fill-or-kill immediate-or-cancel limit market) }

  it { should respond_to :price }
  it { should validate_numericality_of(:price).is_greater_than(0).only_integer }

  it { should respond_to :quantity }
  it { should validate_numericality_of(:quantity).is_greater_than(0).only_integer }

  it { should respond_to :symbol }
  it { should validate_presence_of :symbol }

  it { should respond_to :venue }
  it { should validate_presence_of :venue }
end
