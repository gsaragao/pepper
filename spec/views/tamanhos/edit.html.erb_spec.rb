require 'spec_helper'

describe "tamanhos/edit" do
  before(:each) do
    @tamanho = assign(:tamanho, stub_model(Tamanho,
      :descricao => "MyString",
      :observacao => "MyText"
    ))
  end

  it "renders the edit tamanho form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tamanhos_path(@tamanho), :method => "post" do
      assert_select "input#tamanho_descricao", :name => "tamanho[descricao]"
      assert_select "textarea#tamanho_observacao", :name => "tamanho[observacao]"
    end
  end
end
