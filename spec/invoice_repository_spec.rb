require 'spec_helper'
require 'csv'
require './lib/invoice_repository'

RSpec.describe InvoiceRepository do
  before(:each) do
    @invoices_data = CSV.read('./spec/fixtures/invoices_fixture.csv', headers: true, header_converters: :symbol)
    @inv_repo = InvoiceRepository.new(@invoices_data)
  end
  
  describe 'instance methods' do
    context '#new' do
      it 'initializes an InvoiceRepo with all Invoices loaded' do
        expect(@inv_repo).to be_an InvoiceRepository
        expect(@inv_repo.all).to be_an Array
        expect(@inv_repo.all.first).to be_an Invoice
        expect(@inv_repo.all.size).to eq(99)
        expect(@inv_repo.engine).to be_nil
      end
    end
  end
end
