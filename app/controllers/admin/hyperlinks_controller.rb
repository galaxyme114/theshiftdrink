class Admin::HyperlinksController < Admin::BaseController
  before_action :find_issue, :find_article, :find_page
  before_action :find_hyperlink, only: [:edit, :update, :destroy]

  # => GET /issues/:issue_id/:article_id/pages/:page_id/hyperlinks
  def index
    @hyperlinks = @page.hyperlinks.order(:coord_x)
  end

  # => GET /issues/:issue_id/:article_id/pages/:page_id/hyperlinks/new
  def new
    @hyperlink = @page.hyperlinks.new
  end

  # => POST /issues/:issue_id/:article_id/pages/:page_id/hyperlinks
  def create
    @hyperlink = @page.hyperlinks.new hyperlink_params.merge(user: current_user)

    if @hyperlink.save
      redirect_to page_hyperlinks_path(@issue, @article, @page), notice: 'Hyperlink was created'
    else
      flash.now[:danger] = @hyperlink.first_error_message
      render :new
    end
  end

  # => GET /issues/:issue_id/:article_id/pages/:page_id/hyperlinks/:id/edit
  def edit
  end

  # => PATCH /issues/:issue_id/:article_id/pages/:page_id/hyperlinks/:id
  def update
    if @hyperlink.update(hyperlink_params)
      redirect_to page_hyperlinks_path(@issue, @article, @page, @hyperlink), notice: 'Hyperlink was updated'
    else
      flash.now[:danger] = @hyperlink.first_error_message
      render :edit
    end
  end

  # => DELETE /issues/:issue_id/:article_id/pages/:page_id/hyperlinks/:id
  def destroy
    @hyperlink.destroy
    redirect_to page_hyperlinks_path(@issue, @article, @page), notice: 'Hyperlink was removed'
  end

  protected
    def find_page
      @page = Page.find params[:page_id]
    end

    def find_hyperlink
      @hyperlink = @page.hyperlinks.find params[:id]
    end

    def hyperlink_params
      params.require(:hyperlink).permit(:source_url, :coord_x, :coord_y, :coord_w, :coord_h)
    end
end
