require "spec_helper"

describe VendedoresController do
  describe "routing" do

    it "routes to #index" do
      get("/vendedores").should route_to("vendedores#index")
    end

    it "routes to #new" do
      get("/vendedores/new").should route_to("vendedores#new")
    end

    it "routes to #show" do
      get("/vendedores/1").should route_to("vendedores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/vendedores/1/edit").should route_to("vendedores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/vendedores").should route_to("vendedores#create")
    end

    it "routes to #update" do
      put("/vendedores/1").should route_to("vendedores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/vendedores/1").should route_to("vendedores#destroy", :id => "1")
    end

  end
end
