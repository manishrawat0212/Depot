class RatingsController < ApplicationController  
  def new
    @product = Product.find(params[:id])
    @rating = Rating.new    
  end

  def create
    @rating = Rating.new(rating_params)
    previous_rating = Rating.find_by("product_id = ? and user_id = ?", params[:rating][:product_id], params[:rating][:user_id])
    if previous_rating.present?
      previous_rating.update(rate: params[:rating][:rate])
      redirect_to products_url, notice: "Thanks for updating your rating for #{@rating.product.title}."
    else
      @rating.save      
      redirect_to products_url, notice: "Thanks for rating #{@rating.product.title}."
    end
  end

  private
    def rating_params
      params.require(:rating).permit(:rate, :product_id, :user_id)
    end
end
