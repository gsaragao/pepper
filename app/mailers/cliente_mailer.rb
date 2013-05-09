class ClienteMailer < ActionMailer::Base
  default from: "gtwgtw.bol@gmail.com.br"
  
  def enviar(cliente)
     @cliente = cliente
     @url  = "www.dedodemoca.com"
     mail(:to => cliente.email, 
          :subject => "Venha conferir as novas roupas de Sao Joao 2013.")
  end
  
end
