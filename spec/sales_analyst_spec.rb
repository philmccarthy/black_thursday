require 'spec_helper'
require 'sales_engine'

RSpec.describe SalesAnalyst do
  before(:each) do
    files = {
      merchants: './spec/fixtures/merchants_fixture.csv',
      items: './spec/fixtures/items_fixture.csv'
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
        expect(avg_items_per_merchant).to eq(0.78)
      end
    end
  end
end
