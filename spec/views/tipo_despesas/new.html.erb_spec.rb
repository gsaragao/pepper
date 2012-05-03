require 'spec_helper'

describe "tipo_despesas/new" do
  before(:each) do
    assign(:tipo_despesa, stub_model(TipoDespesa,
      :descricao => "MyString",
      :observacao => "MyText"
    ).as_new_record)
  end

  it "renders new tipo_despesa form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipo_despesas_path, :method => "post" do
      assert_select "input#tipo_despesa_descricao", :name => "tipo_despesa[descricao]"
      assert_select "textarea#tipo_despesa_observacao", :name => "tipo_despesa[observacao]"
    end
  end
end
