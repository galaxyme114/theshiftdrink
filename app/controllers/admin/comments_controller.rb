class Admin::CommentsController < Admin::BaseController
	before_action :find_comment, only: :destroy

  load_and_authorize_resource

  # => GET /comments
  def index
    @comments = Comment.all.order(:body)
  end

  # => DELETE /comments/:id
  def destroy
    @comment.destroy
    redirect_to comments_path, notice: 'Comment was successfully removed'
  end

  protected
    def find_comment
    	@comment = Comment.find(params[:id])
    end

end
