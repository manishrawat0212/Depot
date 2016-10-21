json.products @products do |product|
  json.title product.title 
  json.category_name product.category.name
end
