class InteractionsController < ApplicationController
  before_action :set_interaction, only: %i[ show edit update destroy ]

  # GET /interactions or /interactions.json
  def index
    @interactions = Interaction.all
  end

  # GET /interactions/1 or /interactions/1.json
  def show
  end

  # GET /interactions/new
  def new
    @contacts = current_user.contacts
    @interaction_types = InteractionType.all
    @interaction = Interaction.new
    #@results = 
  end

  # GET /interactions/1/edit
  def edit
  end

  # POST /interactions or /interactions.json
  def create
    @interaction = current_user.interactions.new(interaction_params)
    @contacts = current_user.contacts

    respond_to do |format|
      if @interaction.save
        format.html { redirect_to interaction_url(@interaction), 
          notice: "Interaction was successfully created." }
        format.json { render :show, status: :created, location: @interaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interactions/1 or /interactions/1.json
  def update
    respond_to do |format|
      if @interaction.update(interaction_params)
        format.html { redirect_to interaction_url(@interaction), 
          notice: "Interaction was successfully updated." }
        format.json { render :show, status: :ok, location: @interaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interactions/1 or /interactions/1.json
  def destroy
    @interaction.destroy

    respond_to do |format|
      format.html { redirect_to interactions_url, 
        notice: "Interaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interaction
      @interaction = Interaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def interaction_params
      params.require(:interaction).permit(:name, :description, :contact_id, :date,
                                          :length, :location, :i_initiated, 
                                          :interaction_type_id, :user_id)
    end
end
