class CreateResposta < ActiveRecord::Migration[7.2]
  def change
    create_table :resposta do |t|
      t.references :aluno, null: false, foreign_key: true
      t.references :questao, null: false, foreign_key: true
      t.string :alternativa_escolhida

      t.timestamps
    end
  end
end
