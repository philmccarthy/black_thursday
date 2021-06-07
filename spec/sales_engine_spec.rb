require 'spec_helper'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  describe 'class methods' do
    context '::from_csv' do
      it 'initializes a SalesEngine object from CSV data' do
        files = {
          merchants: './spec/fixtures/merchants_fixture.csv',
          items: './spec/fixtures/items_fixture.csv',
          invoices: './spec/fixtures/invoices_fixture.csv'
        }

        se = SalesEngine.from_csv(files)

        expect(se).to be_an_instance_of SalesEngine

        expect(se.merchants).to be_an_instance_of MerchantRepository
        expect(se.merchants.all).to be_an Array
        expect(se.merchants.all.first).to be_an_instance_of Merchant

        expect(se.items).to be_an_instance_of ItemRepository
        expect(se.items.all).to be_an Array
        expect(se.items.all.first).to be_an_instance_of Item

        expect(se.invoices).to be_an_instance_of InvoiceRepository
        expect(se.invoices.all).to be_an Array
        expect(se.invoices.all.first).to be_an_instance_of Invoice

        expect(se.analyst).to be_an_instance_of SalesAnalyst
      end
    end
  end
end
