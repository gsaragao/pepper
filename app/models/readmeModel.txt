#Adicionar no model

before_destroy :no_relation

#quantidade de registros por página
self.per_page = 10

#método de pesquisa por filtro
def self.pesquisar(obj, page)
  where(obj).paginate(:page => page).order("id desc")
end

private

def no_relation
return if vendas.empty?
  errors[:base] << "Este cliente tem venda(s) associada(s): #{vendas.size} registro(s)!"
 false
end