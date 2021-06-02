class SalesAnalyst
  attr_reader :engine

  def initialize(engine=nil)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.count.to_f / engine.merchants.count).round(2)
  end
end
