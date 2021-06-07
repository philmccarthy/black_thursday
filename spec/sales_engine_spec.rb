require 'spec_helper'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  describe 'class methods' do
    context '::from_csv' do
      it 'initializes a SalesEngine object with relational objects generated from CSV' do
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
        expect(se.merchants.engine).to eq(se)

        expect(se.items).to be_an_instance_of ItemRepository
        expect(se.items.all).to be_an Array
        expect(se.items.all.first).to be_an_instance_of Item
        expect(se.items.all.first.merchant).to be_a Merchant
        expect(se.items.engine).to eq(se)

        expect(se.invoices).to be_an_instance_of InvoiceRepository
        expect(se.invoices.all).to be_an Array
        expect(se.invoices.all.first).to be_an_instance_of Invoice
        expect(se.invoices.all.first.merchant).to be_a Merchant
        expect(se.invoices.engine).to eq(se)

        expect(se.analyst).to be_an_instance_of SalesAnalyst
      end
    end
  end
end
