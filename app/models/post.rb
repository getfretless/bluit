class Post < ActiveRecord::Base
  enum post_type: [:link, :text]
  validates :title, length: { maximum: 160 }, presence: true
  validates :link, length: { maximum: 2000 }
  validates :link, presence: true, if: :link?
  validates :body, presence: true, if: :text?
  validates :category_id, presence: true

  belongs_to :category
  default_scope { order(updated_at: :desc).includes(:category) }
end
