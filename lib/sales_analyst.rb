class SalesAnalyst
  attr_reader :engine

  def initialize(engine=nil)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.count.to_f / engine.merchants.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    @avg_items_per_merchant_std_dev ||= begin
      variance = diff_squared(items_per_merchant.values, average_items_per_merchant)
      sum = variance.sum
      divided_sum = sum / (items_per_merchant.size - 1)
      @avg_items_per_merchant_std_dev = Math.sqrt(divided_sum).round(2)
    end
  end

  def items_per_merchant
    engine.items.all.map { |item| item.merchant_id }
    .inject(Hash.new(0)) do |items_per_merchant, item_of_merchant_id|
      items_per_merchant[item_of_merchant_id] += 1
      items_per_merchant
    end
  end

  def merchants_with_high_item_count
    item_count_floor = average_items_per_merchant + average_items_per_merchant_standard_deviation
    items_per_merchant.select do |merchant, item_count|
      item_count > item_count_floor
    end.keys.map do |merchant_id|
      engine.merchants.find_by_id(merchant_id)
    end
  end

  def diff_squared(nums, avg)
    nums.map { |num| (num - avg) ** 2 }
  end
end
