require 'spec_helper'

feature "clientes CRUD" do
  
  background do
    visit clientes_path
  end
  
  scenario "criar um cliente com apenas dados requeridos" do
    click_on 'Novo Cliente'
    fill_in 'cliente_nome', :with => "Neto Teste"
    click_on 'Salvar'
    page.should have_content('Registro criado com sucesso!')
  end

end
