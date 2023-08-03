require 'rails_helper'

RSpec.describe Post, type: :system do
  let(:first_user) do
    User.new(
      name: 'Gerald',
      photo: 'https://drive.google.com/file/d/0B3rzv4Wf0iFMalA0dFZVMWFvZ2M/view?usp=sharing&resourcekey=0-se7mZNdsmz301lxdjrdS_w',
      bio: 'One of the best psychologist in our time',
      post_counter: 0
    )
  end

  let(:post_one) do
    Post.create(
      author_id: first_user.id,
      title: 'Automobile Industry',
      text: 'It is a great industry',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  let(:post_two) do
    Post.new(
      author_id: second_user.id,
      title: 'Blockchain programming',
      text: 'The future is geered towards Blockchain',
      likes_counter: 0,
      comments_counter: 0
    )
  end
  let(:post_three) do
    Post.new(
      author_id: second_user.id,
      title: 'Ruby',
      text: 'It\'s a great language',
      likes_counter: 0,
      comments_counter: 0
    )
  end
  let(:post_four) do
    Post.new(
      author_id: second_user.id,
      title: 'JavaScript',
      text: 'It has become one of the most widely used languages',
      likes_counter: 0,
      comments_counter: 0
    )
  end
  let(:post_five) do
    Post.new(
      author_id: second_user.id,
      title: 'Technology',
      text: 'Technology has come to stay with us',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  let(:second_user) do
    User.new(
      name: 'Stanley',
      photo: 'https://drive.google.com/file/d/0B3rzv4Wf0iFMalA0dFZVMWFvZ2M/view?usp=sharing&resourcekey=0-se7mZNdsmz301lxdjrdS_w',
      bio: 'Great UI engineer',
      post_counter: 0
    )
  end

  let(:comment_one) do
    Comment.create(
      users_id: first_user.id,
      posts_id: post_one.id,
      text: 'This is a greate piece of work'
    )
  end

  let(:comment_two) do
    Comment.create(
      users_id: first_user.id,
      posts_id: post_one.id,
      text: 'This is a great one there'
    )
  end

  before do
    first_user.save!
    second_user.save!
    post_one
    post_two
    comment_one
    comment_two
  end

  context 'Post index page test' do   

    before { visit user_posts_path first_user }

    it 'displays a user\'s profile picture' do
      profile_pic = find('img')

      expect(profile_pic).to be_visible
      expect(profile_pic['src']).to eq first_user.photo
    end

    it 'displays a user\'s name' do
        expect(page).to have_content(first_user.name)
    end

    it ' displays the number of posts written by a user' do
      expect(page).to have_content(first_user.post_counter)
    end

    it 'displays title of a post' do
        expect(page).to have_content(first_user.posts.first.title)
    end

    it 'diplays part of the post\'s body' do
        expect(page).to have_content(first_user.posts.first.text[0..100])
    end
    
    it 'displays the first comments on a post' do
        expect(page).to have_content(first_user.posts.first.comments.first.user.name)
        expect(page).to have_content(first_user.posts.first.comments.first.text[0..30])
    end

    it "displays pagination when there are more posts" do
      next_page_url = user_posts_path(first_user, page: 2)
      
      visit next_page_url    

      expect(next_page_url).to match(%r{/users/\d+/posts\?page=\d+})
    end

    it 'displays the number of likes for a post' do
        expect(page).to have_content("likes:#{first_user.posts.first.likes_counter}")
    end

    it 'displays how many comments a post has' do
        expect(page).to have_content("comments:#{first_user.posts.first.comments_counter}")
    end
  end
end