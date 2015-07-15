class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.page params[:page]
  end

  def show
  end

  def new
    @post = Post.new
    @post.post_type = params[:post_type] if params[:post_type].present?
  end

  def create
    @post = Post.new post_params
    if @post.save
      redirect_to posts_path, flash: { :'alert-success' => 'Thanks for submitting your post!' }
    else
      flash.now[:'alert-danger'] = @post.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update post_params
      redirect_to posts_path, flash: { :'alert-success' => 'Your post has been updated.' }
    else
      flash.now[:'alert-danger'] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, flash: { :'alert-success' => 'Your post has been removed.' }
    else
      redirect_to posts_path, flash: { :'alert-danger' => 'We were unable to remove that post. Perhaps someone already removed it.' }
    end
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :link, :body, :post_type, :category_id)
  end
end
