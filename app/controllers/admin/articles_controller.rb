class Admin::ArticlesController < Admin::BaseController
  before_action :find_issue
  before_action :find_article, except: [:create, :sort]
  before_action :find_front_page, only: [:edit, :update, :destroy]

  load_and_authorize_resource

  # => POST /issues/:issue_id/articles
  def create
    @article = @issue.articles.new article_params.merge(creator: current_user)

    if @article.save
      redirect_to pages_path(@issue, @article), notice: 'Article was created'
    else
			flash.now[:danger] = @article.first_error_message
      render json: @article.first_error_message
    end
  end

  # => GET /issues/:issue_id/articles/:id/edit
  def edit
  end

  # => PATCH /issues/:issue_id/articles/:id
  def update
    if @article.update(article_params)
      @page.update_attributes(page_params) unless @page.nil? || !params[:article][:custom_thumbnail]

      @article = @article.reload
      redirect_to edit_issue_article_path(@article.issue, @article), notice: 'Article was updated'
    else
      flash.now[:danger] = ( @article.first_error_message ||= @page.first_error_message )
      render :edit
    end
  end

  # => DELETE /issues/:issue_id/articles/:id
  def destroy
    unless @issue.articles_count == 1
      @article.destroy
      redirect_to pages_path(@issue, @issue.first_article), notice: 'Article was removed'
    else
      flash.now[:danger] = 'Each issue must have at least one article'
      render :edit
    end
  end

  # => PATCH /issues/:issue_id/articles/:id/sort
  def sort
    articles = @issue.articles.where(id: params[:article])

    params[:article].each_with_index do |id, index|
      article = articles.select { |a| a['id'] == id }[0]
      article.update_attribute(:position, index) unless article.nil?
    end

    articles.first.pages.first.save

    render nothing: true
  end

  protected
    def article_params
      params.require(:article).permit(:title, :author_id, :friendly_id, :issue_id, :content, :social_title, :title_pic, :social_thumbnail, :thumbnail, :description)
    end

    def page_params
      params.require(:article).require(:page).permit(:crop_h, :crop_w, :crop_x, :crop_y)
    end

    def find_front_page
      @page = @article.front_page
    end
end
