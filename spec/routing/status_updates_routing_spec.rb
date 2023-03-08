require "rails_helper"

RSpec.describe StatusUpdatesController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/status_updates/new").to route_to("status_updates#new")
    end

    it "routes to #create" do
      expect(post: "/status_updates").to route_to("status_updates#create")
    end
  end
end
