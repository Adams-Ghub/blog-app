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

end