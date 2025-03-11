require "test_helper"

class QuestaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @questao = questaos(:one)
  end

  test "should get index" do
    get questaos_url
    assert_response :success
  end

  test "should get new" do
    get new_questao_url
    assert_response :success
  end

  test "should create questao" do
    assert_difference("Questao.count") do
      post questaos_url, params: { questao: { alternativas: @questao.alternativas, categorias: @questao.categorias, enunciado: @questao.enunciado, pontuacao: @questao.pontuacao } }
    end

    assert_redirected_to questao_url(Questao.last)
  end

  test "should show questao" do
    get questao_url(@questao)
    assert_response :success
  end

  test "should get edit" do
    get edit_questao_url(@questao)
    assert_response :success
  end

  test "should update questao" do
    patch questao_url(@questao), params: { questao: { alternativas: @questao.alternativas, categorias: @questao.categorias, enunciado: @questao.enunciado, pontuacao: @questao.pontuacao } }
    assert_redirected_to questao_url(@questao)
  end

  test "should destroy questao" do
    assert_difference("Questao.count", -1) do
      delete questao_url(@questao)
    end

    assert_redirected_to questaos_url
  end
end
