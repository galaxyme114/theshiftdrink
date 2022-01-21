class Admin::IssuesController < Admin::BaseController
  before_action :find_issue, only: [:edit, :update, :destroy]

  load_and_authorize_resource

  # => GET /admin/issues
  def index
    @issues = Issue.publications.order(:number)
  end

  # => POST /admin/issues
  def create
    @issue = Issue.new issue_params.merge(creator: current_user)

    if @issue.save
      redirect_to issues_path, notice: 'Issue was successfully created'
    else
      flash.now[:danger] = @issue.first_error_message
      render :new
    end
  end

  # => GET /admin/issues/:id/edit
  def edit
  end

  # => PATCH /admin/issues/:id
  def update
    if @issue.update(issue_params)
      redirect_to edit_issue_path(@issue), notice: 'Issue was successfully updated'
    else
      flash.now[:danger] = @issue.first_error_message
      render :edit
    end
  end
  
  # => DELETE /admin/issues/:id
  def destroy
  end

  protected
    def issue_params
      params.require(:issue).permit(:number, :alias_name, :title, :orientation, :published_on)
    end
end