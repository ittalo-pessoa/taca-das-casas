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

      Respostum.create!(aluno: @aluno, questao: questao, alternativa_escolhida: alternativa_escolhida)

      alternativa = questao.alternativas.find { |alt| alt.downcase == alternativa_escolhida.downcase }

      puts "Alternativa escolhida: #{alternativa_escolhida}"
      puts "Alternativa encontrada: #{alternativa}"

      if alternativa
        categoria_para_casa = {
          "js" => "JavaScript",
          "html" => "HTML",
          "css" => "CSS"
        }

        casa_nome = categoria_para_casa[alternativa.downcase]
        if casa_nome
          casa = Casa.find_by(nome: casa_nome)
          if casa
            pontuacao_por_casa[casa] += questao.pontuacao
            puts "Adicionando #{questao.pontuacao} pontos para a casa #{casa.nome}"
          else
            puts "Casa não encontrada para a alternativa: #{alternativa}"
          end
        else
          puts "Categoria não mapeada para a alternativa: #{alternativa}"
        end
      else
        puts "Alternativa não encontrada: #{alternativa_escolhida}"
      end
    end

    puts "Pontuações por casa: #{pontuacao_por_casa.inspect}"

    casas_empatadas = pontuacao_por_casa.select { |_casa, pontos| pontos == pontuacao_por_casa.values.max }

    if casas_empatadas.size > 1
      casas_empatadas = casas_empatadas.min_by { |casa, _| casa.alunos.count }.first
      puts "Casa com menos membros: #{casas_empatadas.nome}"
    else
      casas_empatadas = casas_empatadas.keys.first
    end

    if casas_empatadas
      @aluno.update(casa: casas_empatadas)
      puts "Casa escolhida: #{casas_empatadas.nome}"
    else
      puts "Nenhuma casa escolhida"
    end

    redirect_to @aluno, notice: "Aluno criado com sucesso e atribuído à casa #{casas_empatadas&.nome || 'nenhuma'}!"
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
