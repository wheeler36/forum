class CommentsController < ApplicationController
  before_action :set_comment, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!

  def create
    @comment = @post.comments.create(params[:comment].permit(:comment))
    @comment.user = current_user
    @comment.save

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(params[:comment].permit(:comment))
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
  
    def set_comment
      @post = Post.find(params[:post_id])
    end

    def find_comment
      @comment = @post.comments.find(params[:id])
    end
end
