require "rails_helper"

RSpec.describe ConversationItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/conversation_items").to route_to("conversation_items#index")
    end

    it "routes to #new" do
      expect(get: "/conversation_items/new").to route_to("conversation_items#new")
    end

    it "routes to #show" do
      expect(get: "/conversation_items/1").to route_to("conversation_items#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/conversation_items/1/edit").to route_to("conversation_items#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/conversation_items").to route_to("conversation_items#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/conversation_items/1").to route_to("conversation_items#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/conversation_items/1").to route_to("conversation_items#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/conversation_items/1").to route_to("conversation_items#destroy", id: "1")
    end
  end
end
