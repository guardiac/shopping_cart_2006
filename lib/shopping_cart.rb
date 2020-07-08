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
end
