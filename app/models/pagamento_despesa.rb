# encoding: UTF-8
class PagamentoDespesa < ActiveRecord::Base
  belongs_to :despesa
  validates_presence_of :forma_pagamento, :parcela, :valor, :data
end
