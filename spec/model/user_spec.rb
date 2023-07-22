require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'John', photo: 'photo link', bio: 'Great person', post_counter: 0) }


  it 'validates name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'checks post counter' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it 'shows most recent post' do
    expect(subject.show_most_recent_post).to eq(subject.posts.order(updated_at: :desc).limit(3))
  end
end
