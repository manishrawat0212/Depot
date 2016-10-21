class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  before_action :set_i18n_locale_from_params
  before_action :authorize
  
  include SessionsHelper
  before_filter :get_request_starting_time
  after_filter :set_responded_in_custom_header

  before_filter :update_hit_counter

  before_filter :session_expiry
  before_filter :update_activity_time
  protected

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end
    
    def default_url_options
      { locale: I18n.locale }
    end
    
    def session_expiry
      get_session_time_left()
      unless @session_time_left > 0
        session[:user_id] = nil
        flash[:notice] = 'Your session has timed out. Please log back in.'
      end
    end

    def update_activity_time
      session[:expires_at] = Time.now + 30.minutes
    end

    def get_session_time_left
      expire_time = (Time.parse(session[:expires_at]) unless session[:expires_at].nil?) || Time.now
      @session_time_left = (expire_time - Time.now).to_i
    end

    def update_hit_counter
      if cookies[:counter].nil?
        cookies[:counter] = 1
      else
        cookies[:counter] = cookies[:counter].to_i + 1
      end
    end

    def get_request_starting_time
      @start = Time.now
    end

    def set_responded_in_custom_header
      @end = Time.now
      msec = ((@end - @start) * 1000).round(2)
      response.headers['x-responded-in'] = msec.to_s + 'ms'
    end
end
