class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repo

  def initialize(data, repo=nil)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status]
    @created_at = data[:created_at].is_a?(Time) ? data[:created_at] : Time.new(data[:created_at])
    @updated_at = data[:updated_at].is_a?(Time) ? data[:updated_at] : Time.new(data[:updated_at])
    @repo = repo
  end

  def merchant
    return nil if repo.nil?
    @merchant ||= repo.engine.merchants.find_by_id(merchant_id)
  end
end
