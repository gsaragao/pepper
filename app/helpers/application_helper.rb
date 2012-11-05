# encoding : utf-8
module ApplicationHelper
  
  def show_obs(obs)
    new_obs = obs && obs.length > 20 ? obs[0..20].concat('...') : obs
  end
  
  def show_check(value)
     value == 1 ? "Sim" : "Não"
  end

  def formata_float(vlr)
  	retorno = (vlr > 0 || vlr.instance_of?(Dinheiro)) ? vlr.real_formatado : number_to_currency(vlr)
  	retorno
  end


end
