require 'rails_helper'

RSpec.describe "/comments", type: :request do
  let(:valid_attributes) {
    { comment: { content: 'This is a comment.' } }
  }

  let(:invalid_attributes) {
    { comment: { content: '' } }
  }

  describe "GET /new" do
    it "renders a successful response" do
      get new_comment_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comment" do
        expect {
          post comments_url, params: { comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the conversation" do
        post comments_url, params: { comment: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect {
          post comments_url, params: { comment: invalid_attributes }
        }.to change(Comment, :count).by(0)
      end

    
      it "renders a response with 422 status" do
        post comments_url, params: { comment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
