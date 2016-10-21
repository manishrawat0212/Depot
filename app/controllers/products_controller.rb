class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :save_image, only: :create
  before_action :save_updated_image, only: :update

  before_action :set_locale
  after_action :reset_locale

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    3.times { @product.images.build }
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: t('.notice') }
        format.json { render :show, status: :created, location: @product }
      else
        # 3.times { @product.images.build }
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params_without_images)
        format.html { redirect_to @product, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy

    if @product.errors.any?
      @product.errors.full_messages.each do |message|
        flash[:notice] = message
      end
    end
    
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :enabled, :discounted_price, :permalink, :category_id, :category_type, images_attributes: [:url, :product_id])
    end

    def product_params_without_images
      params.require(:product).permit(:title, :description, :image_url, :price, :enabled, :discounted_price, :permalink, :category_id, :category_type)
    end
    
    def save_image
      if(params[:product].has_key?(:images_attributes))
        images = params[:product][:images_attributes]
        uploaded_image1 = images["0"][:url] if images.has_key?("0")
        uploaded_image2 = images["1"][:url] if images.has_key?("1")
        uploaded_image3 = images["2"][:url] if images.has_key?("2")
                
        [uploaded_image1, uploaded_image2, uploaded_image3].each_with_index do |uploaded_image, index|
          unless uploaded_image.nil?
            File.open(Rails.root.join('app', 'assets', 'images', uploaded_image.original_filename), 'wb') do |file|
              file.write(uploaded_image.read)
            end
            images[index.to_s][:url] = uploaded_image.original_filename
          end
        end
      end
    end

    def save_updated_image
      @product.images.each_with_index do |image, index|
        unless params[:product][:images_attributes][index.to_s].blank?
          image.url = params[:product][:images_attributes][index.to_s][:url].original_filename
        end
      end
    end

    def set_locale
      if session[:user_id]
        language = User.find(session[:user_id]).language
        if language == 'hindi'
          I18n.locale = :hi
        else
          I18n.locale = :en
        end
      end
    end

    def reset_locale
      I18n.locale = :en
    end
end
