require "spec_helper"

describe FornecedoresController do
  describe "routing" do

    it "routes to #index" do
      get("/fornecedores").should route_to("fornecedores#index")
    end

    it "routes to #new" do
      get("/fornecedores/new").should route_to("fornecedores#new")
    end

    it "routes to #show" do
      get("/fornecedores/1").should route_to("fornecedores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fornecedores/1/edit").should route_to("fornecedores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fornecedores").should route_to("fornecedores#create")
    end

    it "routes to #update" do
      put("/fornecedores/1").should route_to("fornecedores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fornecedores/1").should route_to("fornecedores#destroy", :id => "1")
    end

  end
end
