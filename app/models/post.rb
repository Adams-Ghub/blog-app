class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'posts_id'
  has_many :comments, foreign_key: 'posts_id'

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def count_post_by_user
    user.update(post_counter: user.posts.count)
  end

  def comments_per_post
    comments.order(created_at: :desc).limit(5)
  end
end
