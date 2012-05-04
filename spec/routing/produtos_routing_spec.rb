require "spec_helper"

describe ProdutosController do
  describe "routing" do

    it "routes to #index" do
      get("/produtos").should route_to("produtos#index")
    end

    it "routes to #new" do
      get("/produtos/new").should route_to("produtos#new")
    end

    it "routes to #show" do
      get("/produtos/1").should route_to("produtos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/produtos/1/edit").should route_to("produtos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/produtos").should route_to("produtos#create")
    end

    it "routes to #update" do
      put("/produtos/1").should route_to("produtos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/produtos/1").should route_to("produtos#destroy", :id => "1")
    end

  end
end
