class Admin::ReportsController < ApplicationController
  before_action :check_permission

  def index
    @from = Date.today - 5.days
    @to = Date.today
  end

  def show_orders
    @from = params[:from]
    @to = params[:to]
  
    respond_to do |format|
      format.js
    end
  end

  private
    def check_permission
      unless User.find(session[:user_id]).role == 'admin'
        flash[:notice] = "You don't have privilege to access this section"
        redirect_to store_url
      end
    end
end
