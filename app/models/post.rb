class Post < ActiveRecord::Base
  validates :title, length: { maximum: 160 }
  validates :link, length: { maximum: 2000 }
end
