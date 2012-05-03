require 'spec_helper'

describe "TipoDespesas" do
  describe "GET /tipo_despesas" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tipo_despesas_path
      response.status.should be(200)
    end
  end
end
