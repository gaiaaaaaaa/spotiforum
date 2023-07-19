require "rails_helper"

RSpec.describe BlacklistsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/blacklists").to route_to("blacklists#index")
    end

    it "routes to #new" do
      expect(get: "/blacklists/new").to route_to("blacklists#new")
    end

    it "routes to #show" do
      expect(get: "/blacklists/1").to route_to("blacklists#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/blacklists/1/edit").to route_to("blacklists#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/blacklists").to route_to("blacklists#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/blacklists/1").to route_to("blacklists#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/blacklists/1").to route_to("blacklists#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/blacklists/1").to route_to("blacklists#destroy", id: "1")
    end
  end
end
