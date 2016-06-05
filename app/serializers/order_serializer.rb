class OrderSerializer < ActiveModel::Serializer # :nodoc:
  attributes :id, :account, :created_at, :direction, :order_type, :price, :quantity, :symbol, :updated_at, :venue
end
