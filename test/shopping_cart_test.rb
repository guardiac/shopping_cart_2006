require 'minitest/autorun'
require 'minitest/pride'
require './lib/product'
require './lib/shopping_cart'

class ShoppingCartTest < Minitest::Test
  def setup
    @cart = ShoppingCart.new("King Soopers", "30items")
  end
  def test_it_exists
    assert_instance_of ShoppingCart, @cart
  end

  def test_it_has_a_name
    assert_equal "King Soopers", @cart.name
  end

  def test_it_has_a_capacity
    assert_equal 30, @cart.capacity
  end

  def test_it_cart_holds_no_products_by_default
    assert_equal [], @cart.products
  end

  def test_it_can_hold_products
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')

    @cart.add_product(product1)
    @cart.add_product(product2)

    assert_equal [product1, product2], @cart.products
  end

  def test_it_can_display_card_details
    cart_details = {name: "King Soopers", capacity: 30}
    assert_equal cart_details, @cart.details
  end

  def test_it_know_the_total_number_of_products
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')

    @cart.add_product(product1)
    @cart.add_product(product2)
    @cart.add_product(product3)

    assert_equal 13, @cart.total_number_of_products
  end

  def test_cart_knows_when_its_full
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    @cart.add_product(product1)
    @cart.add_product(product2)
    @cart.add_product(product3)

    assert_equal false, @cart.is_full?

    product4 = Product.new(:produce, 'apples', 0.99, '20')
    @cart.add_product(product4)

    assert_equal true, @cart.is_full?
  end

  def test_it_can_select_product_by_category
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    product4 = Product.new(:produce, 'apples', 0.99, '20')
    @cart.add_product(product1)
    @cart.add_product(product2)
    @cart.add_product(product3)
    @cart.add_product(product4)

    assert_equal [product1, product3], @cart.products_by_category(:paper)
  end

  def test_it_knows_the_percentage_occupied
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    @cart.add_product(product1)
    @cart.add_product(product2)
    @cart.add_product(product3)

    assert_equal 43.33, @cart.percentage_occupied
  end

  def test_it_can_sort_the_product_by_quantity
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    product4 = Product.new(:produce, 'apples', 0.99, '20')
    @cart.add_product(product1)
    @cart.add_product(product2)
    @cart.add_product(product3)
    @cart.add_product(product4)

    assert_equal [product4, product1, product2, product3], @cart.sorted_products_by_quantity
  end

  def test_it_can_breakdown_the_cart_products_by_category
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    product4 = Product.new(:produce, 'apples', 0.99, '20')
    @cart.add_product(product1)
    @cart.add_product(product2)
    @cart.add_product(product3)
    @cart.add_product(product4)

    expected_breakdown = {
      :meat=>[product2],
      :paper=> [product1, product3],
      :produce=> [product4]
    }

    assert_equal expected_breakdown, @cart.product_breakdown
  end
end
