require "spec_helper"

describe CidadesController do
  describe "routing" do

    it "routes to #index" do
      get("/cidades").should route_to("cidades#index")
    end

    it "routes to #new" do
      get("/cidades/new").should route_to("cidades#new")
    end

    it "routes to #show" do
      get("/cidades/1").should route_to("cidades#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cidades/1/edit").should route_to("cidades#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cidades").should route_to("cidades#create")
    end

    it "routes to #update" do
      put("/cidades/1").should route_to("cidades#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cidades/1").should route_to("cidades#destroy", :id => "1")
    end

  end
end
