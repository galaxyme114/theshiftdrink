class IssueMediaController < ApplicationController
  before_action :find_issue

  # => GET /issues/:issue_id/media
  def index
    @article = @issue.articles.find_by friendly_id: params[:article_id]
    @medias = @article.medias.where(media_type: params[:media].try(:capitalize) || 'Photo')
  end

  protected
    def find_issue
      @issue = Issue.find_by_multiple! [:id, :alias_name, :preview_token], params[:issue_id]      
    end
end
