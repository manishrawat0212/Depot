module ProductsHelper
  def setup_product(product)
    3.times { product.images.build }
    product
  end
end
