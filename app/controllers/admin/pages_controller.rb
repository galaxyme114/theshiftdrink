class Admin::PagesController < Admin::BaseController
  before_action :find_issue, :find_article
  before_action :find_page, only: [:edit, :update, :destroy, :remove_thumb]

  load_and_authorize_resource
  
  # => GET /issues/:issue_id/:article_id/pages
  def index
    @pages = @article.pages.includes(:issue).order(:position)
  end

  # => POST /issues/:issue_id/:article_id/pages
  def create
    ActiveRecord::Base.transaction do
      params[:pages][:image].each do |image|
        @article.pages.create!(image: image)
      end
    end

    @article.pages.last.save # run callbacks

    redirect_to pages_path(@issue, @article), notice: 'Page(s) created successfully'
  end
  
  # => GET /issues/:issue_id/:article_id/pages/:id/edit
  def edit
  end
 
  # => PATCH /issues/:issue_id/:article_id/pages/:id
  def update    
    if @page.update(edit_page_params)
      redirect_to edit_page_path(@issue, @article, @page), notice: 'Page was updated'
    else
      flash.now[:danger] = @page.first_error_message
      render :edit
    end
  end

  # => DELETE /issues/:issue_id/:article_id/pages/:id
  def destroy
    @page.destroy
    redirect_to pages_path(@issue, @article), notice: 'Page has been removed' 
  end

  # => PATCH /issues/:issue_id/:article_id/pages/sort
  def sort
    @pages = @issue.pages.where(id: params[:page])
    values = []

    params[:page].each_with_index do |id, index|
      page = @pages.select { |p| p['id'] == id }[0]
      values.push("(#{page.id}, #{index + 1})") unless page.nil?
    end
    
    unless values.empty?
      ActiveRecord::Base.connection.execute("UPDATE pages as p SET position = c.position from (values #{values.join(',')}) as c(identifier, position) where c.identifier = p.id;")
    end

    @pages.last.save # run callbacks

    render nothing: true
  end

  def remove_thumb
    @page.remove_advertisement_thumb = true and @page.save
    redirect_to edit_page_path(@issue, @article, @page), notice: 'Advertisement thumb removed'
  end

  protected
    def find_page
      @page = Page.find(params[:page_id] ||= params[:id])
    end

    def edit_page_params
      params.require(:page).permit(:title, :position, :full_page_ad, :advertisement_thumb)
    end
end
