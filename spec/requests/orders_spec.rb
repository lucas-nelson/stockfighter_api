require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'GET /orders' do
    it 'returns all the orders' do
      FactoryGirl.create :order, symbol: 'ABCD'
      FactoryGirl.create :order, symbol: 'EFGH'

      get orders_url

      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)
      symbols = body.fetch('data').map { |order| order.fetch('attributes').fetch('symbol') }

      expect(symbols).to match_array(%w(ABCD EFGH))
    end
  end

  describe 'GET /orders/:1' do
    let(:order) { FactoryGirl.create :order }

    it 'returns the specified order' do
      get order_url(order)

      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)

      expect(body.fetch('data').fetch('attributes').fetch('account')).to eq 'GAS68058614'
    end
  end

  describe 'POST /orders' do
    it 'creates the specified order' do
      order = { data: { type: 'orders',
                        attributes: { account: 'ABCEDF0123456789',
                                      direction: 'buy',
                                      order_type: 'limit',
                                      price: 12_500,
                                      quantity: 200,
                                      symbol: 'ZYXW',
                                      venue: 'VUTS' } } }

      expect do
        post orders_url, params: order.to_json, headers: { 'Content-Type': 'application/vnd.api+json' }
      end.to change(Order, :count).by 1

      expect(response).to have_http_status(:created)

      body = JSON.parse(response.body)
      attributes = body.fetch('data').fetch('attributes')

      expect(attributes.fetch('account')).to eq 'ABCEDF0123456789'
      expect(attributes.fetch('direction')).to eq 'buy'
      expect(attributes.fetch('order-type')).to eq 'limit'
      expect(attributes.fetch('price')).to eq 12_500
      expect(attributes.fetch('quantity')).to eq 200
      expect(attributes.fetch('symbol')).to eq 'ZYXW'
      expect(attributes.fetch('venue')).to eq 'VUTS'
    end
  end

  describe 'PUT /orders/:id' do
    it 'updates the specified order' do
      order = FactoryGirl.create :order

      put_order = { data: { type: 'orders', id: order.id, attributes: { quantity: 300 } } }

      put order_url(order), params: put_order.to_json, headers: { 'Content-Type': 'application/vnd.api+json' }

      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)

      expect(body.fetch('data').fetch('attributes').fetch('quantity')).to eq 300
    end
  end

  describe 'DELETE /orders/:id' do
    it 'deletes the specified order' do
      order = FactoryGirl.create :order

      expect do
        delete order_url(order)
      end.to change(Order, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
