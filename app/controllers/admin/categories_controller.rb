class Admin::CategoriesController < ApplicationController
  before_action :check_permission

  def index
    @categories = Category.all
    @subcategories = Subcategory.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @type = params[:type]
    @category = params[:type].constantize.find(params[:id])
    
    render partial: 'category', object: @category
    # render @Category      # error
  end

  private
    def check_permission
      unless User.find(session[:user_id]).role == 'admin'
        flash[:notice] = "You don't have privilege to access this section"
        redirect_to store_url
      end
    end
end
