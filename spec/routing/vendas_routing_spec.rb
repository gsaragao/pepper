require "spec_helper"

describe VendasController do
  describe "routing" do

    it "routes to #index" do
      get("/vendas").should route_to("vendas#index")
    end

    it "routes to #new" do
      get("/vendas/new").should route_to("vendas#new")
    end

    it "routes to #show" do
      get("/vendas/1").should route_to("vendas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/vendas/1/edit").should route_to("vendas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/vendas").should route_to("vendas#create")
    end

    it "routes to #update" do
      put("/vendas/1").should route_to("vendas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/vendas/1").should route_to("vendas#destroy", :id => "1")
    end

  end
end
