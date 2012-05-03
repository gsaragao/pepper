class ClienteMailer < ActionMailer::Base
  default from: "gtwgtw@bol.com.br"
  
  def enviar(cliente)
     @cliente = cliente
     @url  = "www.dedodemoca.ane.com"
     mail(:to => cliente.email, 
          :subject => "Venha conferir as novas roupas de Sao Joao 2012.")
  end
  
end
