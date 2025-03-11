class Questao < ApplicationRecord
  store_accessor :alternativas
  store_accessor :categorias

  validates :enunciado, presence: true
  validates :alternativas, presence: true
  has_many :respostas, class_name: "Respostum", foreign_key: "questao_id", dependent: :destroy

end
