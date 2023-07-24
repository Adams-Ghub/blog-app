require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John', photo: 'photo link', bio: 'user', post_counter: 0) }
  let(:post) do
    Post.create(title: 'Microverse', text: 'post content', author_id: user.id, comments_counter: 0, likes_counter: 0)
  end
  subject { Comment.create(text: 'test', posts_id: post.id, users_id: user.id) }

  it 'increases comments_counter by 1' do
    expect { subject.send(:update_comment_counter) }.to change { post.reload.comments_counter }.by(1)
  end
end
