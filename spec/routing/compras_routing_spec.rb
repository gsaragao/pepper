require "spec_helper"

describe ComprasController do
  describe "routing" do

    it "routes to #index" do
      get("/compras").should route_to("compras#index")
    end

    it "routes to #new" do
      get("/compras/new").should route_to("compras#new")
    end

    it "routes to #show" do
      get("/compras/1").should route_to("compras#show", :id => "1")
    end

    it "routes to #edit" do
      get("/compras/1/edit").should route_to("compras#edit", :id => "1")
    end

    it "routes to #create" do
      post("/compras").should route_to("compras#create")
    end

    it "routes to #update" do
      put("/compras/1").should route_to("compras#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/compras/1").should route_to("compras#destroy", :id => "1")
    end

  end
end
