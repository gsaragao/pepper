#Adicionar no model

#quantidade de registros por página
self.per_page = 10

#método de pesquisa por filtro
def self.pesquisar(obj, page)
  where(obj).paginate(:page => page).order("id desc")
end