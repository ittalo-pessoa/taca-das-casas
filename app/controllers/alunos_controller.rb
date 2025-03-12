class AlunosController < ApplicationController
  before_action :set_aluno, only: [:show, :edit, :destroy, :responder_questoes, :salvar_respostas]

  def index
    @alunos = Aluno.all
  end

  def new
    @aluno = Aluno.new
  end


  def create
    @aluno = Aluno.new(aluno_params)
    @aluno.casa_id = nil # Garantir que a casa não seja definida agora

    if @aluno.save
      # Redireciona para as questões ou página de sucesso
      redirect_to responder_questoes_aluno_path(@aluno)
    else
      # Exibe os erros de validação
      flash[:alert] = "Erro ao salvar o aluno!"
      render :new
    end
  end

  def responder_questoes
    @questoes = Questao.order("RANDOM()").limit(5) # Seleciona 5 questões aleatórias

  end


  def salvar_respostas
    pontuacao_por_casa = Hash.new(0)

    params[:respostas].each do |questao_id, alternativa_escolhida|
      questao = Questao.find(questao_id)

      # Cria a resposta para o aluno e a questão
      Respostum.create!(aluno: @aluno, questao: questao, alternativa_escolhida: alternativa_escolhida)

      # Obtém as alternativas e as categorias associadas
      alternativas = questao.alternativas.map(&:downcase)
      categorias = questao.categorias

      # Encontra o índice da alternativa escolhida
      index = alternativas.index(alternativa_escolhida.downcase)

      if index && index < categorias.size
        # Obtém a categoria correspondente à alternativa
        categoria = categorias[index]

        # Verifica se a categoria é "JS" e substitui por "JavaScript"
        categoria = "JavaScript" if categoria.casecmp("JS").zero?

        # Busca a casa com o nome correto
        casa = Casa.find_by(nome: categoria)

        if casa
          pontuacao_por_casa[casa] += questao.pontuacao
          Rails.logger.info "Adicionando #{questao.pontuacao} pontos para a casa #{casa.nome}"
        else
          Rails.logger.warn "Casa não encontrada para a categoria: #{categoria}"
        end
      else
        Rails.logger.warn "Alternativa não encontrada ou sem categoria: #{alternativa_escolhida}"
      end
    end

    Rails.logger.info "Pontuações por casa: #{pontuacao_por_casa.inspect}"

    # Seleção da casa com maior pontuação (ou desempate por menor número de alunos)
    casa_escolhida = pontuacao_por_casa.max_by { |casa, pontos| [pontos, -casa.alunos.count] }&.first

    if casa_escolhida
      @aluno.update(casa: casa_escolhida)
      Rails.logger.info "Casa escolhida: #{casa_escolhida.nome}"
    else
      Rails.logger.warn "Nenhuma casa escolhida"
    end

    redirect_to @aluno, notice: "Aluno criado com sucesso e atribuído à casa #{casa_escolhida&.nome || 'nenhuma'}!"
  end








  def update
    if @aluno.update(aluno_params)
      redirect_to @aluno, notice: "Aluno atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @aluno.destroy
    redirect_to alunos_path, notice: "Aluno excluído com sucesso!"
  end

  private

  def set_aluno
    @aluno = Aluno.find(params[:id])
  end

  def aluno_params
    params.require(:aluno).permit(:nome, :turma)
  end
end
