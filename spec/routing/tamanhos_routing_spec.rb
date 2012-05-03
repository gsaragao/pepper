require "spec_helper"

describe TamanhosController do
  describe "routing" do

    it "routes to #index" do
      get("/tamanhos").should route_to("tamanhos#index")
    end

    it "routes to #new" do
      get("/tamanhos/new").should route_to("tamanhos#new")
    end

    it "routes to #show" do
      get("/tamanhos/1").should route_to("tamanhos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tamanhos/1/edit").should route_to("tamanhos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tamanhos").should route_to("tamanhos#create")
    end

    it "routes to #update" do
      put("/tamanhos/1").should route_to("tamanhos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tamanhos/1").should route_to("tamanhos#destroy", :id => "1")
    end

  end
end
