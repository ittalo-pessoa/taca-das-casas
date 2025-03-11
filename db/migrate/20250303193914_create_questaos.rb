class CreateQuestaos < ActiveRecord::Migration[7.2]
  def change
    create_table :questaos do |t|
      t.string :enunciado, null: false
      t.json :alternativas, default: []
      t.json :categorias, default: []
      t.integer :pontuacao, null: false, default: 0

      t.timestamps
    end
  end
end
