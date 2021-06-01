require 'spec_helper'
require 'csv'
require './lib/item_repository'

RSpec.describe ItemRepository do
  describe 'instance methods' do
    context 'initialize' do
      it 'instantiates ItemRepository with Item objects loaded' do
        items_data = CSV.read('./spec/fixtures/items_fixture.csv', headers: true, header_converters: :symbol)

        ir = ItemRepository.new(items_data)
        
        expect(ir).to be_an ItemRepository
        expect(ir.all).to be_an Array
        expect(ir.all.first).to be_an Item
        expect(ir.all.size).to eq(7)
      end
    end
  end
end