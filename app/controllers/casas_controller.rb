class CasasController < ApplicationController
  before_action :set_casa, only: %i[ show edit update destroy ]

  # GET /casas or /casas.json
  def index
    @casas = Casa.all
  end

  # GET /casas/1 or /casas/1.json
  def show
  end


  def alunosPorCasa
    @alunosPorCasa = Aluno.all
  end

  # GET /casas/new
  def new
    @casa = Casa.new
  end

  # GET /casas/1/edit
  def edit
  end

  # POST /casas or /casas.json
  def create
    @casa = Casa.new(casa_params)

    respond_to do |format|
      if @casa.save
        format.html { redirect_to @casa, notice: "Casa was successfully created." }
        format.json { render :show, status: :created, location: @casa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @casa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /casas/1 or /casas/1.json
  def update
    respond_to do |format|
      if @casa.update(casa_params)
        format.html { redirect_to @casa, notice: "Casa was successfully updated." }
        format.json { render :show, status: :ok, location: @casa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @casa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /casas/1 or /casas/1.json
  def destroy
    @casa.destroy!

    respond_to do |format|
      format.html { redirect_to casas_path, status: :see_other, notice: "Casa was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_casa
      @casa = Casa.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def casa_params
      params.require(:casa).permit(:nome, :pontos)
    end
end
