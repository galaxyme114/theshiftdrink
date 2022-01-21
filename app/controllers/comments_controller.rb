class CommentsController < ApplicationController  
  before_action :find_article, only: [:index, :create]

  def index    
    respond_to do |format|
      format.js
    end
  end

  def create
    commentable = commentable_type.constantize.find(commentable_id)
    @comment = Comment.build_from(commentable, user_id, body)

    if @comment.save
      make_child_comment
      
      respond_to do |format|
        format.js { render 'comments/index' }
      end
    end
  end

  def update
    @comment = Comment.find params[:id]

    if @comment.update_attributes(body_params)
      respond_to do |format|
        format.json { render json: { message: 'Comment was updated' } }
      end
    end
  end

  protected
    def find_article
      @article = Article.find params[:article_id] ||= commentable_id
      @new_comment = Comment.build_from(@article, user_id, "") 
    end

    def user_id
      ( current_user) ? current_user.id : 0
    end

    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id)
    end

    def body_params
      params.require(:comment).permit(:body)
    end

    def commentable_type
      comment_params[:commentable_type]
    end

    def commentable_id
      comment_params[:commentable_id]
    end

    def comment_id
      comment_params[:comment_id]
    end

    def body
      comment_params[:body]
    end

    def make_child_comment
      return "" if comment_id.blank?

      parent = Comment.find comment_id
      @comment.move_to_child_of(parent)
    end
end  
