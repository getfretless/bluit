class AddPostTypesToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :post_type, :integer, default: 0
    Post.find_each do |post|
      post.post_type = 1 if post.body.present? && post.link.blank?
      post.update_attributes(post_type: 0, body: '') if post.link.present?
      post.save!
    end
  end

  def down
    remove_column :posts, :post_type
  end
end
