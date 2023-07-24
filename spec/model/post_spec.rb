require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'John', photo: 'photo link', bio: 'Great person', post_counter: 0)
  subject do
    Post.create(title: 'firstPost', text: 'Posting is great', author_id: user.id, comments_counter: 0,
                likes_counter: 0)
  end

  it 'must have a title present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'must be an integer greater or equal to zero' do
    subject.comments_counter = -2
    expect(subject).to_not be_valid
  end

  it 'must be an integer greater or equal to zero' do
    subject.comments_counter = 1
    expect(subject).to be_valid
  end

  it 'must be an integer greater or equal to zero' do
    subject.comments_counter = 0
    expect(subject).to be_valid
  end

  it 'must be an integer greater or equal to zero' do
    subject.likes_counter = -2
    expect(subject).to_not be_valid
  end

  it 'must be an integer greater or equal to zero' do
    subject.likes_counter = 1
    expect(subject).to be_valid
  end

  it 'must be an integer greater or equal to zero' do
    subject.likes_counter = 0
    expect(subject).to be_valid
  end

  it 'should update the number of post for a user' do
    expect(user.post_counter).to eq(0)
    subject.count_post_by_user

    expect(user.reload.post_counter).to eq(1)
  end

  it 'should show five most recent comments per a post' do
    expect(subject.comments_per_post).to eq(subject.comments.order(created_at: :desc).limit(5))
  end
end
