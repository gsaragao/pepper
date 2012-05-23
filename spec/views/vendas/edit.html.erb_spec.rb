require 'spec_helper'

describe "vendas/edit" do
  before(:each) do
    @venda = assign(:venda, stub_model(Venda,
      :cliente => nil,
      :vendedor => nil,
      :observacao => "MyText"
    ))
  end

  it "renders the edit venda form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => vendas_path(@venda), :method => "post" do
      assert_select "input#venda_cliente", :name => "venda[cliente]"
      assert_select "input#venda_vendedor", :name => "venda[vendedor]"
      assert_select "textarea#venda_observacao", :name => "venda[observacao]"
    end
  end
end
