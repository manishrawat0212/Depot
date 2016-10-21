json.products category.products do |product|
  json.(product, :title)
end

if @type == 'Category'
  json.subproducts category.subcategories do |subcategory|
    subcategory.products.each do |product|
      json.(product, :title)
    end
  end
end
