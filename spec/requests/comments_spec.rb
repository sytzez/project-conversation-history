require 'rails_helper'

RSpec.describe '/comments', type: :request do
  let(:valid_attributes) do
    { content: 'This is a comment.' }
  end

  let(:invalid_attributes) do
    { content: '' }
  end

  context 'when signed in' do
    let(:user) { create :user }
    before { sign_in user }

    describe 'GET /new' do
      it 'renders a successful response' do
        get new_comment_url
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Comment' do
          expect {
            post comments_url, params: { comment: valid_attributes }
          }.to change(Comment, :count).by(1)
        end

        it 'redirects to the conversation' do
          post comments_url, params: { comment: valid_attributes }
          expect(response).to redirect_to(root_url)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Comment' do
          expect {
            post comments_url, params: { comment: invalid_attributes }
          }.to change(Comment, :count).by(0)
        end

        it 'renders a response with 422 status' do
          post comments_url, params: { comment: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  context 'when not signed in' do
    describe 'GET /new' do
      it 'redirects to the sign in page' do
        get new_comment_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST /new' do
      it 'redirects to the sign in page' do
        post comments_url, params: { comment: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
