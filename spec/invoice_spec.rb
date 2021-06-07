require 'spec_helper'
require 'csv'
require './lib/invoice'

RSpec.describe Invoice do
  describe 'initialize' do
    it 'exists and has attributes' do
      invoice_data = CSV.read('./spec/fixtures/invoices_fixture.csv', headers: true, header_converters: :symbol).first
      invoice = Invoice.new(invoice_data)

      expect(invoice).to be_an Invoice
      
      expect(invoice.id).to eq(invoice_data[:id].to_i)
      expect(invoice.id).to be_an Integer

      expect(invoice.customer_id).to eq(invoice_data[:customer_id].to_i)
      expect(invoice.customer_id).to be_an Integer

      expect(invoice.merchant_id).to eq(invoice_data[:merchant_id].to_i)
      expect(invoice.merchant_id).to be_an Integer

      expect(invoice.status).to eq(invoice_data[:status])
      expect(invoice.status).to be_an String
      
      expect(invoice.created_at).to eq(Time.new(invoice_data[:created_at]))
      expect(invoice.created_at).to be_a Time
      
      expect(invoice.updated_at).to eq(Time.new(invoice_data[:updated_at]))
      expect(invoice.updated_at).to be_a Time
    end
  end
end
