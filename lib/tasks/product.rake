namespace :product do
  desc "Assign the first category to all existing products."
  task :port_legacy_products => :environment do
    begin
      first_category = Category.first
      category_type = 'Category'
      category_name = first_category.name
      category_id = first_category.id
      Product.find_each do |p|
        p.update(category_id: category_id, category_type: category_type);
      end
      puts "Done!!! All existing products are assigned category #{category_name}."
    rescue
      puts 'Something went wrong!!!'
    end
  end
end

# Call:
# rake "product:port_legacy_products"
