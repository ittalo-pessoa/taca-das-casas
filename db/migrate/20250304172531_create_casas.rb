class CreateCasas < ActiveRecord::Migration[7.2]
  def change
    create_table :casas do |t|
      t.string :nome
      t.integer :pontos

      t.timestamps
    end
  end
end
