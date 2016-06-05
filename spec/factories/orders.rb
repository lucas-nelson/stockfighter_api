FactoryGirl.define do
  factory :order do
    account 'GAS68058614'
    direction 'buy'
    order_type 'limit'
    price 25_000
    quantity 100
    symbol 'CDSC'
    venue 'YEHKEX'
  end
end
