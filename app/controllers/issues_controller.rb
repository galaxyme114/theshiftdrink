class IssuesController < ApplicationController

  skip_before_action :authenticate_user!

  before_action :check_device, :only => :published

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  layout 'client'

  # GET => /issues/:id
  def published
    @issue = Issue.published.find_by!(alias_name: params[:issue_id])
    find_resources()
  end

  def previewed
    @issue = Issue.find_by!(preview_token: params[:issue_id])

    find_resources()
  end

  def advertisement
    respond_to do |format|
      format.js { render 'issues/ads' }
    end
  end

  def interstitial
    respond_to do |format|
      format.js { render 'issues/interstitial' }
    end
  end

  protected
    def find_resources()
      @page = @issue.pages.find_by(friendly_id: params[:id]) unless params[:id].blank?
      @thumbnails = @issue.pages.where("pages.position = 1 OR coalesce(advertisement_thumb, '') != ''")
      @articles = @issue.articles.order(:position)
      @current_article = @articles.select{|a| a.id == @page.try(:article_id) }[0]
      @current_article = @articles.first if @current_article.blank?
      @front_page = @current_article.front_page
    end

    def check_device
			(params[:test]) ? return : (0);
			if (!params[:issue_id])
				redirect_to ((browser.device.mobile? || browser.device.tablet? ) ? "/m-issue" : "/issue")
			elsif ((browser.device.mobile? || browser.device.tablet?) && !params[:issue_id].include?("m-"))
        complete_path = "m-"
				params[:issue_id] = complete_path + params[:issue_id]
	      redirect_to "/#{params[:issue_id]}/#{params[:id]}"
			elsif (!(browser.device.mobile? || browser.device.tablet?) && params[:issue_id].include?("m-"))
				params[:issue_id] = params[:issue_id][2,params[:issue_id].length]
				redirect_to "/#{params[:issue_id]}/#{params[:id]}"
      end
		end
end
