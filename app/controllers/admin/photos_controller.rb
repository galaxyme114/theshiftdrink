class Admin::PhotosController < Admin::BaseController
  before_action :find_issue, :find_article

  load_and_authorize_resource

  # => GET /issues/:issue_id/:article_id/photos
  def index
    @photos = @article.photos.order(:position)
  end

  def create
    params[:photos][:image].each do |image|
      @article.photos.create!(image: image, creator: current_user)
    end

    redirect_to photos_path(@issue, @article), notice: 'Page(s) created successfully'
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
