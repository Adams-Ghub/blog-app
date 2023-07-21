class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'users_id'
  belongs_to :post, foreign_key: 'posts_id'

  def update_comment_counter
    post.increment!(:comments_counter)
  end
end
