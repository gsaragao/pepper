# encoding : utf-8
module ApplicationHelper
  
  def show_obs(obs)
    new_obs = obs && obs.length > 20 ? obs[0..20].concat('...') : obs
  end
  
  def show_check(value)
     value == 1 ? "Sim" : "Não"
  end

end
