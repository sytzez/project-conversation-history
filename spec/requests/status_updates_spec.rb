require 'rails_helper'

RSpec.describe "/status_updates", type: :request do
  let(:valid_attributes) {
    { status_update: { status: 'planned' } }
  }

  let(:invalid_attributes) {
    { status_update: { status: '' } }
  }

  describe "GET /new" do
    it "renders a successful response" do
      get new_status_update_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new StatusUpdate" do
        expect {
          post status_updates_url, params: { status_update: valid_attributes }
        }.to change(StatusUpdate, :count).by(1)
      end

      it "redirects to the conversation" do
        post status_updates_url, params: { status_update: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new StatusUpdate" do
        expect {
          post status_updates_url, params: { status_update: invalid_attributes }
        }.to change(StatusUpdate, :count).by(0)
      end

    
      it "renders a response with 422 status" do
        post status_updates_url, params: { status_update: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
