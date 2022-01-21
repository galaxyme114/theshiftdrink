class Admin::MediaController < Admin::BaseController
  before_action :find_issue, :find_article
  before_action :find_media, only: [:edit, :update, :destroy]

  # load_and_authorize_resource :class => Media, :find_by => :friendly_id

  # => GET /issues/:issue_id/:article_id/media
  def index
    @medias = @article.medias.includes(:issue).order(:position)
  end

  # => GET /issues/:issue_id/:article_id/media/new
  def new
  end

  # => POST /issues/:issue_id/:article_id/media
  def create
    @media = @article.medias.new media_params.merge(creator: current_user)

    if @media.save
      redirect_to media_path(@issue, @article), notice: 'Media added successfully'
    else
      flash.now[:danger] = @media.first_error_message
      redirect_to media_path(@issue, @article)
    end
  end

  # => POST /issues/:issue_id/:article_id/media/multiple
  def multiple
    params[:medias][:asset].each do |asset|
      @article.medias.create!(asset: asset, creator: current_user)
    end

    redirect_to media_path(@issue, @article), notice: 'Media added successfully'
  end

  # => GET /issues/:issue_id/:article_id/media/:id/edit
  def edit
  end

  # => PATCH /issues/:issue_id/:article_id/media/:id
  def update
    if @media.update media_params
      redirect_to edit_medium_path(@issue, @article, @media), notice: 'Media updated successfully'
    else
      flash.now[:danger] = @article.first_error_message
      redirect_to edit_medium_path(@issue, @article, @media)
    end
  end

  # => DELETE /issues/:issue_id/:article_id/media/:id
  def destroy
    @media.destroy
    redirect_to media_path(@issue, @article), notice: 'Media has been removed' 
  end

  protected
    def find_media
      @media = Media.find_by! friendly_id: params[:id]
    end

    def media_params
      params.require(:media).permit(:asset, :override_url)
    end
end