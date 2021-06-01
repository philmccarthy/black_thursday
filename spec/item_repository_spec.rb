require 'spec_helper'
require 'csv'
require './lib/item_repository'

RSpec.describe ItemRepository do
  before(:each) do
    @items_data = CSV.read('./spec/fixtures/items_fixture.csv', headers: true, header_converters: :symbol)
    @ir = ItemRepository.new(@items_data)
  end
  
  describe 'instance methods' do

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

    it '#find_by_name' do
      item = @ir.find_by_name('Glitter scrabble frames')

      expect(item).to be_an Item
      expect(item.name).to eq('Glitter scrabble frames')
    end
  end
end