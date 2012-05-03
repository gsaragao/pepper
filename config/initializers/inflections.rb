# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
inflect.plural /^([a-zA-z]*)al$/i, '\1ais'
inflect.singular /^([a-zA-z]*)ais$/i, '\1al'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
  inflect.irregular 'cor', 'cores'
  inflect.irregular 'home', 'home'
  inflect.irregular 'categoria', 'categorias'
  inflect.irregular 'fornecedor', 'fornecedores'
  inflect.irregular 'vendedor', 'vendedores'
 end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end
