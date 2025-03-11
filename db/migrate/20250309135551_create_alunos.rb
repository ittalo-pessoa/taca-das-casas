class CreateAlunos < ActiveRecord::Migration[7.2]
  def change
    create_table :alunos do |t|
      t.string :nome
      t.string :turma
      t.references :casa, null: false, foreign_key: true

      t.timestamps
    end
  end
end
