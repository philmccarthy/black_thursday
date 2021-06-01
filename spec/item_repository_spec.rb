require 'spec_helper'
require 'csv'
require './lib/item_repository'

RSpec.describe ItemRepository do
  describe 'instance methods' do
    before(:each) do
      @items_data = CSV.read('./spec/fixtures/items_fixture.csv', headers: true, header_converters: :symbol)
      @ir = ItemRepository.new(@items_data)
    end

    it 'initializes with with all Items loaded' do
      
      expect(@ir).to be_an ItemRepository
      expect(@ir.all).to be_an Array
      expect(@ir.all.first).to be_an Item
      expect(@ir.all.size).to eq(7)
    end

    it '#find_by_id' do
      item = @ir.find_by_id(263395617)

      expect(item).to be_an Item
      expect(item.id).to eq(@items_data[0][:id].to_i)
    end
  end
end