Pepper::Application.routes.draw do

  devise_for :users

  resources :vendas

  resources :produtos do 
    collection do
        get 'auto'
    end
  end
  
  resources :pagamento_vendas, :except => [:new]
  
  resources :vendedores

  resources :fornecedores

  resources :cidades

  resources :despesas

  resources :categorias do 
    collection do
        get 'auto'
    end
  end
  
  resources :cores

  resources :tamanhos

  resources :marcas

  resources :tipo_despesas

  resources :compras do 
    collection do
        get 'calcula'
    end
  end

  resources :clientes do 
    collection do
        get 'auto'
    end
  end

  resources :home, :only => [:index]

  resources :analise, :only => [:index]
  
  root :to => 'home#index'
 
end
