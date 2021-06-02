require 'spec_helper'
require 'csv'
require 'bigdecimal/util'
require './lib/item'

RSpec.describe Item do
  describe 'initialize' do
    it 'exists and has attributes' do
      item_data = CSV.read('./spec/fixtures/items_fixture.csv', headers: true, header_converters: :symbol).first
      
      item = Item.new(item_data)

      expect(item).to be_an_instance_of Item
      
      expect(item.id).to eq(item_data[:id].to_i)
      expect(item.id).to be_an Integer

      expect(item.name).to eq(item_data[:name])
      expect(item.name).to be_a String
      
      expect(item.description).to eq(item_data[:description])
      expect(item.description).to be_a String
      
      expect(item.unit_price).to eq(item_data[:unit_price].to_d)
      expect(item.unit_price).to be_a BigDecimal

      
      expect(item.created_at).to eq(Time.new(item_data[:created_at]))
      expect(item.created_at).to be_a Time
      
      expect(item.updated_at).to eq(Time.new(item_data[:updated_at]))
      expect(item.updated_at).to be_a Time

      expect(item.merchant_id).to eq(item_data[:merchant_id].to_i)
      expect(item.merchant_id).to be_an Integer
    end
  end
end
