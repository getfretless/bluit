class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    find_post
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
    find_post
  end

  def update
    find_post
    if @post.update post_params
      redirect_to posts_path, flash: { :'alert-success' => 'Your post has been updated.' }
    else
      flash.now[:'alert-danger'] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :link, :body, :post_type)
  end
end
