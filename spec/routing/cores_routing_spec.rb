require "spec_helper"

describe CoresController do
  describe "routing" do

    it "routes to #index" do
      get("/cores").should route_to("cores#index")
    end

    it "routes to #new" do
      get("/cores/new").should route_to("cores#new")
    end

    it "routes to #show" do
      get("/cores/1").should route_to("cores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cores/1/edit").should route_to("cores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cores").should route_to("cores#create")
    end

    it "routes to #update" do
      put("/cores/1").should route_to("cores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cores/1").should route_to("cores#destroy", :id => "1")
    end

  end
end
