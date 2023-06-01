class InteractionTypesController < ApplicationController
  before_action :set_interaction_type, only: %i[ show edit update destroy ]

  # GET /interaction_types or /interaction_types.json
  def index
    @interaction_types = InteractionType.all
  end

  # GET /interaction_types/1 or /interaction_types/1.json
  def show
  end

  # GET /interaction_types/new
  def new
    @interaction_type = InteractionType.new
  end

  # GET /interaction_types/1/edit
  def edit
  end

  # POST /interaction_types or /interaction_types.json
  def create
    @interaction_type = InteractionType.new(interaction_type_params)

    respond_to do |format|
      if @interaction_type.save
        format.html { redirect_to interaction_type_url(@interaction_type), notice: "Interaction type was successfully created." }
        format.json { render :show, status: :created, location: @interaction_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @interaction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interaction_types/1 or /interaction_types/1.json
  def update
    respond_to do |format|
      if @interaction_type.update(interaction_type_params)
        format.html { redirect_to interaction_type_url(@interaction_type), notice: "Interaction type was successfully updated." }
        format.json { render :show, status: :ok, location: @interaction_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interaction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interaction_types/1 or /interaction_types/1.json
  def destroy
    @interaction_type.destroy

    respond_to do |format|
      format.html { redirect_to interaction_types_url, notice: "Interaction type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interaction_type
      @interaction_type = InteractionType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def interaction_type_params
      params.require(:interaction_type).permit(:name, :description)
    end
end
