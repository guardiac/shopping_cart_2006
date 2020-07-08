class ShoppingCart
  attr_reader :name, :capacity, :products, :total_number_of_products
  def initialize(name, capacity)
    @name = name
    @capacity = capacity[0..1].to_i
    @products = []
    @total_number_of_products = 0
  end

  def add_product(product)
    @products << product
    @total_number_of_products += product.quantity
  end

  def details
    {name: @name, capacity: @capacity}
  end

  def is_full?
    @total_number_of_products > @capacity
  end

  def products_by_category(product_category)
    @products.select { |product| product.category == product_category }
  end

  def percentage_occupied
    ((@total_number_of_products.to_f / @capacity) * 100).round(2)
  end

  def sorted_products_by_quantity
    (@products.sort_by { |product| product.quantity }).reverse
  end

  def product_breakdown
    breakdown = {}
    product_categories.each do |category|
      breakdown[category] = products_by_category(category)
    end
    breakdown
  end

  def product_categories
    (products.map { |product| product.category }).uniq
  end
end
