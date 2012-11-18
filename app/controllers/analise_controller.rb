# encoding : utf-8
class AnaliseController < ApplicationController

   respond_to :html
   before_filter :setar_classe_menu

   def index

   	@completo = nil

   	if params[:completo]
   		@completo = params[:completo]
   	end	

    if @completo
       @class_completo = 'active'
       @analise_completa = Analise.analise_completa
       @retorno = totalizador(@analise_completa)
    else
    	 @class_estrela = 'active'
    	 @analise_estrelas = Analise.analise_estrelas
    end   
  end
 
  private
  
  def setar_classe_menu
    @class_analise = 'active'  
  end

  def totalizador(lista)
  	
  	retorno = []
  	retorno[0] = 0
 	  retorno[1] = 0
 	  retorno[2] = 0 
	  retorno[3] = 0
	  retorno[4] = 0
	  retorno[5] = 0
	  retorno[6] = 0	
	  retorno[7] = 0	
	  retorno[8] = 0	

  	if !lista.empty?

  		lista.each {|analise| 
  			 retorno[0] += analise.valor_total
				 retorno[1] += 	analise.cartao_dinheiro
				 retorno[2] += analise.cheque_duplicata
				 retorno[3] += 	analise.parcelas_total
				 retorno[4] += 	analise.parcelas_cartao_dinheiro
				 retorno[5] += 	analise.antes
				 retorno[6] += 	analise.no_prazo
				 retorno[7] += 	analise.quinze
				 retorno[8] += 	analise.trinta
  		}
  	end	
  	retorno
  end

end
