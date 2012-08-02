class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  layout :define_layout
  
  def define_layout
    if user_signed_in?
      "application"
    else
      "logoff"
    end
  end
  
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
