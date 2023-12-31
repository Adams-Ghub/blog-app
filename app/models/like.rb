class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'users_id'
  belongs_to :post, foreign_key: 'posts_id'

  def update_likes_counter_per_post
    post.increment!(:likes_counter)
  end
end
