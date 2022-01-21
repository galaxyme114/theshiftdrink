class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  
  layout 'admin'
  
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    message = 'You do not have permission to access this resource'
    
    if current_user && current_user.is_role?('Reader')
      sign_out current_user
      redirect_to new_user_session_path, flash: { notice: message }
    else
      redirect_to issues_path, flash: { notice: message }
    end
  end

  protected
    def find_issue
      @issue = Issue.find_by_multiple! [:id, :number, :alias_name], (params[:issue_id] ||= params[:id])
    end

    def find_article
      @article = @issue.articles.find_by!(friendly_id: params[:article_id] ||= params[:id])
    end
end