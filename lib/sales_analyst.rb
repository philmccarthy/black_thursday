class SalesAnalyst
  attr_reader :engine

  def initialize(engine=nil)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.count.to_f / engine.merchants.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    variance = diff_squared(items_per_merchant.values, average_items_per_merchant)
    sum = variance.sum
    divided_sum = sum / (items_per_merchant.size - 1)
    Math.sqrt(divided_sum).round(2)
  end

  def items_per_merchant
    engine.items.all.map { |item| item.merchant_id }
    .inject(Hash.new(0)) do |items_per_merchant, item_of_merchant_id|
      items_per_merchant[item_of_merchant_id] += 1
      items_per_merchant
    end
  end

  def diff_squared(nums, avg)
    nums.map { |num| (num - avg) ** 2 }
  end
end
