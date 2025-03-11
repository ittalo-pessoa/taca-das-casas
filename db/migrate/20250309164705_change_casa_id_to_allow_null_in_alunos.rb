class ChangeCasaIdToAllowNullInAlunos < ActiveRecord::Migration[7.2]
  def change
    change_column_null :alunos, :casa_id, true
  end
end
