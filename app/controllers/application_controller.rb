class ApplicationController < ActionController::Base
  protect_from_forgery

  def trata_data(att_data)
     if (!att_data.empty?)
          data = att_data.gsub("/", "-")
          att_data = Time.parse(data).strftime("%Y-%m-%d")
      end
      att_data
  end
  
  def reverte_data(att_data)
      data = att_data.to_s.gsub("-", "/")
      att_data = Time.parse(data).strftime("%d/%m/%Y")
      att_data
  end
  
  
end
