class Aluno < ApplicationRecord
  belongs_to :casa, optional: true
  has_many :respostas, class_name: "Respostum", foreign_key: "aluno_id", dependent: :destroy

  validates :nome, presence: true
  validates :turma, presence: true
end
