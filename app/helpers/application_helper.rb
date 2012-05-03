module ApplicationHelper
  
  def show_obs(obs)
    new_obs = obs && obs.length > 40 ? obs[0..40].concat('...') : obs
  end
  
end
