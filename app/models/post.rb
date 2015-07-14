class Post < ActiveRecord::Base
  validates :title, length: { maximum: 160 }, presence: true
  validates :link, length: { maximum: 2000 }
end
