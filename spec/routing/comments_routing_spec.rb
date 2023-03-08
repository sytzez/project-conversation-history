require "rails_helper"

RSpec.describe CommentsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/comments/new").to route_to("comments#new")
    end
  end
end
