module ApplicationHelper
  def post_link(post)
    return post.link if post.link?
    return post_path(post) if post.text?
  end
end
