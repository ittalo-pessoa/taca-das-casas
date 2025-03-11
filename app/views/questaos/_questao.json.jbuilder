json.extract! questao, :id, :enunciado, :alternativas, :categorias, :pontuacao, :created_at, :updated_at
json.url questao_url(questao, format: :json)
