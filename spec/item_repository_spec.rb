require 'spec_helper'
require 'csv'
require 'bigdecimal'
require './lib/item_repository'

RSpec.describe ItemRepository do
  before(:each) do
    @items_data = CSV.read('./spec/fixtures/items_fixture.csv', headers: true, header_converters: :symbol)
    @ir = ItemRepository.new(@items_data)
  end
  
  describe 'instance methods' do
    context '#new' do
      it 'initializes an ItemRepo with all Items loaded' do
        expect(@ir).to be_an ItemRepository
        expect(@ir.all).to be_an Array
        expect(@ir.all.first).to be_an Item
        expect(@ir.all.size).to eq(7)
      end
    end

    context '#find_by_id' do
      it 'returns one item with matching id' do
        item = @ir.find_by_id(263395617)
  
        expect(item).to be_an Item
        expect(item.id).to eq(@items_data[0][:id].to_i)
      end
    end

    context '#find_by_name' do
      it 'returns one item by matching name' do
        item = @ir.find_by_name('Glitter scrabble frames')

        expect(item).to be_an Item
        expect(item.name).to eq('Glitter scrabble frames')
      end
    end

    context '#find_all_with_description' do
      it 'returns an array of all matching items with given description' do
        description = 'any'
        items = @ir.find_all_with_description(description)

        expect(items).to be_an Array
        expect(items.size).to eq(5)
        expect(items.first).to be_a Item
      end

      it 'returns an empty array when no matches exist' do
        description = 'askjdsakjf'
        items = @ir.find_all_with_description(description)

        expect(items).to be_an Array
        expect(items).to be_empty
      end
    end

    context '#find_all_by_price' do
      it 'returns all items with an exact price match' do
        price = 1300
        items = @ir.find_all_by_price(price)
        
        expect(items).to be_an Array
        expect(items.size).to eq(1)
        
        expect(items.first).to be_an Item
        expect(items.first.unit_price).to eq(price)
      end
      
      it 'returns empty array if no price match' do
        price = 123456
        items = @ir.find_all_by_price(price)

        expect(items).to be_empty
      end
    end

    context '#find_all_by_price' do
      it 'returns all items that match given price range' do
        range = (1000..1500)
        items = @ir.find_all_by_price_in_range(range)
        
        expect(items).to be_an Array
        expect(items.size).to eq(3)
        
        expect(items.first).to be_an Item
        expect(items.first.unit_price).to be_between(range.first, range.last)
      end
      
      it 'returns empty array if no price match' do
        range = (0..1)
        items = @ir.find_all_by_price_in_range(range)

        expect(items).to be_empty
      end
    end

    context '#find_all_by_merchant_id' do
      it 'returns an array of items belonging to given merchant' do
        merchant_id = 12334185
        items = @ir.find_all_by_merchant_id(merchant_id)

        expect(items).to be_an Array
        expect(items.size).to eq(3)
        expect(items.first).to be_an Item
        expect(items.first.merchant_id).to eq(merchant_id)
      end

      it 'returns an empty array when no items belong to given merchant_id' do
        extinct_merchant_id = -10
        items = @ir.find_all_by_merchant_id(extinct_merchant_id)

        expect(items).to be_empty
      end
    end

    context '#create' do
      it 'creates an item from attributes' do
        attributes = {
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal(10.99,4),
          :created_at  => Time.now.to_s,
          :updated_at  => Time.now.to_s,
          :merchant_id => 2
        }
        
        old_item = @ir.all.last

        @ir.create(attributes)
        new_item = @ir.all.last

        expect(new_item).to_not eq(old_item)

        expect(new_item.id).to eq(old_item.id + 1)
        expect(new_item.name).to eq(attributes[:name])
        expect(new_item.description).to eq(attributes[:description])
        expect(new_item.unit_price).to eq(attributes[:unit_price])
        expect(new_item.created_at).to eq(DateTime.parse(attributes[:created_at]))
        expect(new_item.updated_at).to eq(DateTime.parse(attributes[:updated_at]))
        expect(new_item.merchant_id).to eq(attributes[:merchant_id])
      end
    end
  end
end
