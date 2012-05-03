require "spec_helper"

describe MarcasController do
  describe "routing" do

    it "routes to #index" do
      get("/marcas").should route_to("marcas#index")
    end

    it "routes to #new" do
      get("/marcas/new").should route_to("marcas#new")
    end

    it "routes to #show" do
      get("/marcas/1").should route_to("marcas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/marcas/1/edit").should route_to("marcas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/marcas").should route_to("marcas#create")
    end

    it "routes to #update" do
      put("/marcas/1").should route_to("marcas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/marcas/1").should route_to("marcas#destroy", :id => "1")
    end

  end
end
