require "rails_helper"

RSpec.describe ConversationItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/").to route_to("conversation_items#index")
    end
  end
end
