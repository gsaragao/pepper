# encoding : utf-8
class VendasController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index, :create, :update]
  before_filter :load_venda , :only => [:show, :edit, :update, :destroy]

  def index
    @clientes = Cliente.order(:nome)
    @vendedores = Vendedor.order(:nome)
    @venda = Venda.new(params[:venda])
    @vendas = Venda.pesquisar(params[:venda],params[:page])
    respond_with @vendas
  end

  def show
    respond_with @venda
  end

  def new
    load_combos
    @vendedor_default = Vendedor.find_by_default(Vendedor::DEFAULT)
    @venda = Venda.new
    @venda.vendedor_id = @vendedor_default.id if @vendedor_default
    @venda.data = Date.today

    if (params[:cliente_id])
      @venda.cliente = Cliente.find(params[:cliente_id])
    end
    
    respond_with @venda
  end

  def edit
    carrega_pagamento_venda
    reverte_datas_pagamento
    load_combos
  end

  def create
  
    @venda = Venda.new(params[:venda])
    
    Venda.transaction do

      registra_produto(@venda)
      registra_pagamento(@venda)

      if @venda.save

        @venda.produtos.each {|produto| 
          produto.venda_id = @venda.id
          produto.save
        }
        
        @venda.pagamento_vendas.each {|pagamento| 
          pagamento.venda_id = @venda.id
          pagamento.save
        }
        
        flash[:notice] = t('msg.create_sucess')
        redirect_to vendas_path
      else
        reverte_datas_pagamento
        load_combos
        render :action => :new 
        raise ActiveRecord::Rollback
      end
    end 
  end

  def update
    
     Venda.transaction do  

        @venda_pagamento = Venda.new(params[:venda])
        registra_pagamento(@venda_pagamento)
        registra_produto(@venda_pagamento)

        if @venda.update_attributes(params[:venda])

          Produto.where(:venda_id => @venda.id).update_all(:venda_id => nil)
          @venda_pagamento.lista_produtos.each {|k,v| 
            produto = Produto.find(v[:id]) 
            produto.valor_vendido = v[:valor_vendido]
            produto.venda_id = @venda.id
            produto.save
          }

          PagamentoVenda.destroy_all(:venda_id => @venda.id)
          @venda_pagamento.pagamento_vendas.each {|pagamento| 
            pagamento.venda_id = @venda.id
            pagamento.save
          }
          
          flash[:notice] = t('msg.update_sucess')
          redirect_to vendas_path
        else
          reverte_datas_pagamento
          load_combos
           @venda.produtos = []
            if @venda.lista_produtos
              @venda.lista_produtos.each {|k,v| 
                produto = Produto.find(v[:id]) 
                produto.valor_vendido = v[:valor_vendido]
                @venda.produtos << produto 
              }
            end
          render :action => :edit
          raise ActiveRecord::Rollback
        end
     end  
  end

  def destroy
    
    if @venda.destroy
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @venda.errors.full_messages[0]
    end

    redirect_to vendas_path
  end
  
  private
  
  def setar_classe_menu
    @class_venda = 'active'  
  end
  
  def load_venda
    begin
      @venda = Venda.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to vendas_path
    end
  end
  
  def load_combos 
    @clientes = Cliente.order(:nome)
    @vendedores = Vendedor.order(:nome)
  end
  
  def manage_params
    if (!params[:venda].nil?) 
       params[:venda][:data] = trata_data(params[:venda][:data]) if params[:venda][:data]
       params[:venda][:data_duplicata] = trata_data(params[:venda][:data_duplicata]) if params[:venda][:data_duplicata]
       params[:venda][:data_cartao] = trata_data(params[:venda][:data_cartao]) if params[:venda][:data_cartao]
       params[:venda][:data_cheque] = trata_data(params[:venda][:data_cheque]) if params[:venda][:data_cheque]
       params[:venda].delete_if{|k,v| v.blank?}
    end
  end
  
  def registra_pagamento(venda)
    
    if (venda.valor_dinheiro && !venda.valor_dinheiro.empty? && venda.valor_dinheiro.to_f > 0)
       pagamento = PagamentoVenda.new
       pagamento.forma_pagamento = Venda::DINHEIRO
       pagamento.parcela = 1
       pagamento.valor = venda.valor_dinheiro
       pagamento.data = venda.data
       venda.pagamento_vendas << pagamento
    end  

    if (venda.valor_duplicata && !venda.valor_duplicata.empty? && venda.valor_duplicata.to_f > 0 && !venda.data_duplicata.blank?)
      
      data = Date.strptime(venda.data_duplicata)
      venda.parcela_duplicata.to_i.times {|i|
      
         pagamento = PagamentoVenda.new
         pagamento.forma_pagamento = Venda::DUPLICATA
         pagamento.parcela = i + 1
         pagamento.valor = (trata_valor(venda.valor_duplicata).to_f / venda.parcela_duplicata.to_i).round(2)
         pagamento.data = data
         venda.pagamento_vendas << pagamento       
         
         data += 1.month
      }   
    end  
    
    if (venda.valor_cartao && !venda.valor_cartao.empty? && venda.valor_cartao.to_f > 0 && !venda.data_cartao.blank?)
      
      data = Date.strptime(venda.data_cartao)
      venda.parcela_cartao.to_i.times {|i|
      
         pagamento = PagamentoVenda.new
         pagamento.forma_pagamento = Venda::CARTAO
         pagamento.parcela = i + 1
         pagamento.valor = (trata_valor(venda.valor_cartao).to_f / venda.parcela_cartao.to_i).round(2)
         pagamento.valor_pago = pagamento.valor
         pagamento.data = data
         pagamento.data_pagamento_cliente = data
         venda.pagamento_vendas << pagamento       
       
         data += 1.month
      }   
    end  
    
    if (venda.valor_cheque && !venda.valor_cheque.empty? && venda.valor_cheque.to_f > 0 && !venda.data_cheque.blank?)
      
      data = Date.strptime(venda.data_cheque)
      venda.parcela_cheque.to_i.times {|i|
      
         pagamento = PagamentoVenda.new
         pagamento.forma_pagamento = Venda::CHEQUE
         pagamento.parcela = i + 1
         pagamento.valor = (trata_valor(venda.valor_cheque).to_f / venda.parcela_cheque.to_i).round(2)
         pagamento.valor_pago = pagamento.valor
         pagamento.data = data
         pagamento.data_pagamento_cliente = data
         venda.pagamento_vendas << pagamento       
       
         data += 1.month
      }   
    end  
  end
  
  def carrega_pagamento_venda
    
    pagamentos = PagamentoVenda.pesquisar_por_venda(@venda.id)
    
    if (pagamentos)
    
      pagamentos.each {|pag|
      
        if (pag.forma_pagamento == Venda::DINHEIRO)
            @venda.valor_dinheiro = pag.valor
        end 
      
        if (pag.forma_pagamento == Venda::DUPLICATA)
            @venda.valor_duplicata = pag.valor * pag.parcela
            @venda.parcela_duplicata = pag.parcela
            @venda.data_duplicata = pag.data
        end

        if (pag.forma_pagamento == Venda::CARTAO)
            @venda.valor_cartao = pag.valor * pag.parcela
            @venda.parcela_cartao = pag.parcela
            @venda.data_cartao = pag.data
        end

        if (pag.forma_pagamento == Venda::CHEQUE)
            @venda.valor_cheque = pag.valor * pag.parcela
            @venda.parcela_cheque = pag.parcela
            @venda.data_cheque = pag.data
        end
      }
    end

  end
  
  def registra_produto(venda)
    venda.produtos = []
    if venda.lista_produtos
       venda.lista_produtos.each {|k,v|
         produto = Produto.find(v[:id]) 
         produto.valor_vendido = v[:valor_vendido]
         venda.produtos << produto
      }
    end
  end
  
  def trata_valor(valor) 
     valor = valor.sub('.',''); 
     valor = valor.sub(',','.');    
  end

  def reverte_datas_pagamento
     @venda.data_duplicata = reverte_data(@venda.data_duplicata) if @venda.data_duplicata
     @venda.data_cartao = reverte_data(@venda.data_cartao) if @venda.data_cartao
     @venda.data_cheque = reverte_data(@venda.data_cheque) if @venda.data_cheque
  end
  
end
