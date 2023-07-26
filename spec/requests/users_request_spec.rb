require 'rails_helper'

RSpec.describe UsersController, type: :request do
  context 'GET /index' do
    it 'returns http success' do
      get '/users/index'
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get '/users'
      expect(response).to render_template('index')
    end

    it 'should include correct placeholder' do
      get '/users'
      expect(response.body).to include('Here is the list of all users')
    end
  end

  context 'GET /show' do
    it 'returns http success' do
      get '/users/1'
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get '/users/1'
      expect(response).to render_template('show')
    end

    it 'should include correct placeholder' do
      get '/users/1'
      expect(response.body).to include('this is the first users')
    end
  end
end
