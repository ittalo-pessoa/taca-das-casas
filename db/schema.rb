# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_03_09_164705) do
  create_table "alunos", force: :cascade do |t|
    t.string "nome"
    t.string "turma"
    t.integer "casa_id", null: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["casa_id"], name: "index_alunos_on_casa_id"
  end

  create_table "casas", force: :cascade do |t|
    t.string "nome"
    t.integer "pontos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questaos", force: :cascade do |t|
    t.text "enunciado"
    t.json "alternativas"
    t.json "categorias"
    t.integer "pontuacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resposta", force: :cascade do |t|
    t.integer "aluno_id", null: false
    t.integer "questao_id", null: false
    t.string "alternativa_escolhida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aluno_id"], name: "index_resposta_on_aluno_id"
    t.index ["questao_id"], name: "index_resposta_on_questao_id"
  end

  add_foreign_key "alunos", "casas"
  add_foreign_key "resposta", "alunos"
  add_foreign_key "resposta", "questaos"
end
