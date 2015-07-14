class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(params.require(:post).permit(:title, :link, :body))
    if post.save
      redirect_to posts_path
    else
      redirect_to new_post_path
    end
  end
end
