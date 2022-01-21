class Api::V1::PagesController < Api::V1::BaseController
  before_action :find_pages, only: [:index]

  # => GET /v1/issues/:issue_id/pages
  def index
    render json: (@pages ||= []), status: 200
  end

  # => GET /v1/issues/:issue_id/pages/:position
  def show
    @page = Page.find_by(issue_id: params[:issue_id], master_position: params[:position])

    unless @page.nil?
      render json: @page, status: 200
    else
      render json: { message: 'Record not found', status_code: 404 }, status: 404
    end
  end

  protected
    def find_pages
      @pages = Page.unscoped.find_for_issue(params[:issue_id])
    end
end