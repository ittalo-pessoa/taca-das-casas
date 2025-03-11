require "application_system_test_case"

class CasasTest < ApplicationSystemTestCase
  setup do
    @casa = casas(:one)
  end

  test "visiting the index" do
    visit casas_url
    assert_selector "h1", text: "Casas"
  end

  test "should create casa" do
    visit casas_url
    click_on "New casa"

    fill_in "Nome", with: @casa.nome
    fill_in "Pontos", with: @casa.pontos
    click_on "Create Casa"

    assert_text "Casa was successfully created"
    click_on "Back"
  end

  test "should update Casa" do
    visit casa_url(@casa)
    click_on "Edit this casa", match: :first

    fill_in "Nome", with: @casa.nome
    fill_in "Pontos", with: @casa.pontos
    click_on "Update Casa"

    assert_text "Casa was successfully updated"
    click_on "Back"
  end

  test "should destroy Casa" do
    visit casa_url(@casa)
    click_on "Destroy this casa", match: :first

    assert_text "Casa was successfully destroyed"
  end
end
