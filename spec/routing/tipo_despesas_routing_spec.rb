require "spec_helper"

describe TipoDespesasController do
  describe "routing" do

    it "routes to #index" do
      get("/tipo_despesas").should route_to("tipo_despesas#index")
    end

    it "routes to #new" do
      get("/tipo_despesas/new").should route_to("tipo_despesas#new")
    end

    it "routes to #show" do
      get("/tipo_despesas/1").should route_to("tipo_despesas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tipo_despesas/1/edit").should route_to("tipo_despesas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tipo_despesas").should route_to("tipo_despesas#create")
    end

    it "routes to #update" do
      put("/tipo_despesas/1").should route_to("tipo_despesas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tipo_despesas/1").should route_to("tipo_despesas#destroy", :id => "1")
    end

  end
end
