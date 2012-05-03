require 'spec_helper'

describe "despesas/new" do
  before(:each) do
    assign(:despesa, stub_model(Despesa,
      :compra => nil,
      :tipo_despesa => nil,
      :valor => "9.99"
    ).as_new_record)
  end

  it "renders new despesa form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => despesas_path, :method => "post" do
      assert_select "input#despesa_compra", :name => "despesa[compra]"
      assert_select "input#despesa_tipo_despesa", :name => "despesa[tipo_despesa]"
      assert_select "input#despesa_valor", :name => "despesa[valor]"
    end
  end
end
