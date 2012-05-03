require 'spec_helper'

describe "tipo_despesas/show" do
  before(:each) do
    @tipo_despesa = assign(:tipo_despesa, stub_model(TipoDespesa,
      :descricao => "Descricao",
      :observacao => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Descricao/)
    rendered.should match(/MyText/)
  end
end
