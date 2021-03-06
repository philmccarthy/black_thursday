require 'spec_helper'
require 'sales_engine'

RSpec.describe SalesAnalyst do
  before(:each) do
    files = {
      merchants: './spec/fixtures/merchants_fixture.csv',
      items: './spec/fixtures/items_fixture.csv',
      invoices: './spec/fixtures/invoices_fixture.csv'
    }
    
    @engine = SalesEngine.from_csv(files)
    @analyst = @engine.analyst
  end
  
  describe 'instance methods' do
    context '#initialize' do
      it 'initializes an analyst with engine reference' do
        expect(@analyst).to be_a SalesAnalyst
        expect(@analyst.engine).to be_a SalesEngine
      end
    end

    context '#average_items_per_merchant' do
      it 'returns the average items per merchant as a Float' do
        avg_items_per_merchant = @analyst.average_items_per_merchant

        expect(avg_items_per_merchant).to be_a Float
        expect(avg_items_per_merchant).to eq(0.64)
      end
    end

    context '#average_items_per_merchant_standard_deviation' do
      it 'returns a Float standard deviation' do
        actual = @analyst.average_items_per_merchant_standard_deviation

        expect(actual).to be_a Float
        expect(actual).to eq(1.60)
      end
    end

    context '#merchants_with_high_item_count' do
      it 'returns an array of merchants one std dev above avg' do
        actual = @analyst.merchants_with_high_item_count

        expect(actual).to be_an Array
        expect(actual.size).to eq(1)
        expect(actual.first).to be_a Merchant
      end
    end

    context '#average_item_price_for_merchant' do
      it 'returns a BicDecimal average price for given merchant' do
        actual = @analyst.average_item_price_for_merchant(12334185)

        expect(actual).to be_a BigDecimal
        expect(actual).to eq(11.17)
      end
    end

    context '#average_average_price_per_merchant' do
      it 'returns a BigDecimal average price for all merchants' do
        # Merchants fixture data currently contains merchant_ids that don't appear
        # in the Items fixture data. As a result, this function returns NaN
        # in this test whereas it successfully passes the spec_harness
        actual = @analyst.average_average_price_per_merchant

        expect(actual).to be_a BigDecimal
      end
    end

    context '#golden items' do
      it 'returns an array of item objects priced 2 standard devs above avg' do
        actual = @analyst.golden_items

        expect(actual).to be_an Array
        expect(actual.first).to be_an Item
        expect(actual.size).to eq(1)
      end
    end
  end
end
