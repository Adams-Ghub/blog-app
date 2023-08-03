require 'rails_helper'

RSpec.describe User, type: :system do
  let(:person_one) do
    User.new(
      name: 'John Snow',
      photo: 'https://drive.google.com/file/d/0B3rzv4Wf0iFMalA0dFZVMWFvZ2M/view?usp=sharing&resourcekey=0-se7mZNdsmz301lxdjrdS_w',
      bio: 'One of the characters of Game of Thrones',
      post_counter: 0
    )
  end

  let(:person_two) do
    User.new(
      name: 'Seth Amoah',
      photo: 'https://drive.google.com/file/d/0B3rzv4Wf0iFMalA0dFZVMWFvZ2M/view?usp=sharing&resourcekey=0-se7mZNdsmz301lxdjrdS_w',
      bio: 'Proud student of Havard',
      post_counter: 0
    )
  end

  let(:post_one) do    
      Post.create(
        author_id: person_two.id,
        title: 'Reomote Software Development',
        text: 'Lately Software Developers work from various places in the world',
        likes_counter: 0,
        comments_counter: 0
    )
  end
 
  let(:post_two) do    
      Post.create(
        author_id: person_two.id,
        title: 'Education',
        text: 'It one thing that cannot be taken out of life',
        likes_counter: 0,
        comments_counter: 0
    )
  end
  
  let(:post_three) do    
      Post.create(
        author_id: person_two.id,
        title: 'Automobile Industry',
        text: 'One of the greatest industries in the world now is the automobile industry',
        likes_counter: 0,
        comments_counter: 0
    )
  end

  before  do
    person_one.save!
    person_two.save!
  end
 
  context "index test" do
    before {visit root_path}
      it "shows usernames of all users" do
        expect(page).to have_content(person_one.name)
        expect(page).to have_content(person_two.name)
      end

      it 'shows profile picture of users' do
        profile_pics = all('img.profile-image')
        expect(profile_pics[0]).to be_visible
        expect(profile_pics[1]).to be_visible
        expect(profile_pics[0]['src']).to eq person_one.photo
        expect(profile_pics[1]['src']).to eq person_two.photo
      end 

      it 'shows number of post written by each user' do
        expect(page).to have_content person_one.post_counter
        expect(page).to have_content person_two.post_counter
      end

      it 'takes me to show page when I click a user' do
        person_one_show_page_url= "#{Capybara.app_host}/users/#{person_one.id}"
      
        click_link person_one.name
        
        expect(page).to have_current_path(person_one_show_page_url)
      end

  end

  context 'show page tests' do
    subject{person_two}
    before do
      post_one
      post_two
      post_three
      visit user_path person_two
    end

    it 'display user profile picture' do
      profile_pic = find('.profile-image')
      
      expect(profile_pic).to be_visible
      expect(profile_pic['src']).to eq subject.photo
    end

    it 'display the username of a user' do
        expect(page).to have_content(subject.name)
    end

    it 'display number of posts made by a user' do
      expect(page).to have_content subject.post_counter
    end
    
    it 'display bio of a user' do
      expect(page).to have_content subject.bio
    end

    it 'displays user\'s first three post' do
      expect(page).to have_content subject.posts[0].title
      expect(page).to have_content subject.posts[1].title
      expect(page).to have_content subject.posts[2].title
    end

    it 'displays see all posts button' do  
      expect(page).to have_link('see all posts')
    end

    it 'takes me to posts show page when I click a post' do
      post_two_show_page_url= "#{Capybara.app_host}/users/#{person_two.id}/posts/#{person_two.posts.first.id}"
      
      all('a.link-to-specific-post').each do |link|       
        link.click
        expect(page).to have_current_path(post_two_show_page_url)
        expect(page).to have_content(person_two.posts.first.title)
      end

   
      
    end

    it 'redirects to the post index page when the see all Posts button is clicked' do
      all_posts_url = "#{Capybara.app_host}/users/#{subject.id}/posts"
      click_link 'see all posts'
      
      expect(page).to have_current_path(all_posts_url)
    end

  end
  
end