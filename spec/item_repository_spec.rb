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
        price = 13
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
        range = (10..15)
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
        expect(new_item.unit_price).to eq(attributes[:unit_price].to_d / 100)
        expect(new_item.created_at).to eq(Time.new(attributes[:created_at]))
        expect(new_item.updated_at).to eq(Time.new(attributes[:updated_at]))
        expect(new_item.merchant_id).to eq(attributes[:merchant_id])
      end
    end

    context '#update' do
      it 'updates an items attributes' do
        id = 263395617
        item = @ir.find_by_id(id)
        before_name = item.name
        before_desc = item.description
        before_price = item.unit_price

        attributes = {
          :name        => "New Stuff",
          :description => "It is extra fresh",
          :unit_price  => 100.50,
        }

        @ir.update(id, attributes)

        expect(item.name).to_not eq(before_name)
        expect(item.description).to_not eq(before_desc)
        expect(item.unit_price).to_not eq(before_price)
        expect(item.updated_at.round(0)).to eq(Time.now.utc.round(0))
      end

      it 'only updates name, desc, price and updated_at' do
        id = 263395617
        item = @ir.find_by_id(id)
        before_id = item.id
        before_merchant_id = item.merchant_id
        before_created_at = item.created_at

        attributes = {
          :id          => 1,
          :merchant_id => 10000000,
          :created_at  => Time.now.to_s,
        }

        expect(item.id).to eq(before_id)
        expect(item.merchant_id).to eq(before_merchant_id)
        expect(item.created_at).to eq(before_created_at)
      end
    end

    context '#delete' do
      it 'deletes an instance of item from the repository' do
        before_count = @ir.all.size
        item_id = 263395617
        
        @ir.delete(item_id)
        
        after_count = @ir.all.size

        expect(after_count).to_not eq(before_count)
        expect(@ir.find_by_id(item_id)).to be_nil
      end
    end

    context '#inspect' do
      it 'inherits overriden inspect method from Repositable' do
        expect(@ir.inspect).to eq("#<ItemRepository 7 rows>")
      end
    end
  end
end
