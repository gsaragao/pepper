require "spec_helper"

describe CategoriasController do
  describe "routing" do

    it "routes to #index" do
      get("/categorias").should route_to("categorias#index")
    end

    it "routes to #new" do
      get("/categorias/new").should route_to("categorias#new")
    end

    it "routes to #show" do
      get("/categorias/1").should route_to("categorias#show", :id => "1")
    end

    it "routes to #edit" do
      get("/categorias/1/edit").should route_to("categorias#edit", :id => "1")
    end

    it "routes to #create" do
      post("/categorias").should route_to("categorias#create")
    end

    it "routes to #update" do
      put("/categorias/1").should route_to("categorias#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/categorias/1").should route_to("categorias#destroy", :id => "1")
    end

  end
end
