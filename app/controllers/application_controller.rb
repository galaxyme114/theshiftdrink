class ApplicationController < ActionController::Base
  # include LocalSubdomain
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout :layout_by_resource

  protected
    def render_404(exception = nil)
      logger.info("Rendering 404: #{exception.message}") if exception

      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end

    def layout_by_resource
      ( devise_controller? ) ? 'admin' : 'client'
    end
end
