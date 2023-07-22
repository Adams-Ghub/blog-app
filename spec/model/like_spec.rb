require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'test', photo: 'photo link', bio: 'user', post_counter: 0) }
  let(:post) do
    Post.create(title: 'test', text: 'post content', author_id: user.id, comments_counter: 0, likes_counter: 0)
  end
  subject { Like.create(posts_id: post.id, users_id: user.id) }

  it 'should increments likes_counter by 1' do
    expect { subject.send(:update_likes_counter_per_post) }.to change { post.reload.likes_counter }.by(1)
  end
end
