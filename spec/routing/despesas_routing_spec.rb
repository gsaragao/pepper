require "spec_helper"

describe DespesasController do
  describe "routing" do

    it "routes to #index" do
      get("/despesas").should route_to("despesas#index")
    end

    it "routes to #new" do
      get("/despesas/new").should route_to("despesas#new")
    end

    it "routes to #show" do
      get("/despesas/1").should route_to("despesas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/despesas/1/edit").should route_to("despesas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/despesas").should route_to("despesas#create")
    end

    it "routes to #update" do
      put("/despesas/1").should route_to("despesas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/despesas/1").should route_to("despesas#destroy", :id => "1")
    end

  end
end
