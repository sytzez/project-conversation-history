require 'rails_helper'

RSpec.describe '/', type: :request do
  context 'when signed in' do
    let(:user) { create :user }
    before { sign_in user }

    describe 'GET /' do
      it 'renders a successful response' do
        get root_url
        expect(response).to be_successful
      end
    end
  end

  context 'when not signed in' do
    describe 'GET /' do
      it 'redirects to the sign in page' do
        get root_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
