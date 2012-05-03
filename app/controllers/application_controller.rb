class ApplicationController < ActionController::Base
  protect_from_forgery

  def trata_data(att_data)
     if (!att_data.empty?)
          data = att_data.gsub!("/", "-")
          att_data = Time.parse(data).strftime("%Y-%m-%d")
      end
      att_data
  end
  
end
