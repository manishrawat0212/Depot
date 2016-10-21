class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout "myorders", only: [:orders, :line_items]

  def orders
    @orders = User.find_by(id: session[:user_id]).orders
    @total = 0
    @orders.each do |order|
      order.line_items.each do |line_item|
        @total += line_item.product.price
      end
    end
  end

  def line_items
    @pagination_size = 4
    @current_user = User.find_by(id: session[:user_id])
    @line_items_count = @current_user.line_items.size
  end

  def show_line_items
    respond_to do |format|
      format.js
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user.build_address
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.destroy
      flash[:notice] = "User #{@user.name} deleted"  
    else
      @user.errors.full_messages.each do |message|
        flash[:notice] = message
      end
    end
    
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :role, :password, :password_confirmation, :language, address_attributes:[:city, :state, :country, :pincode])
    end
end
