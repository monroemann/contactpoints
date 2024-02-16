class InteractionsController < ApplicationController
  before_action :set_interaction, only: %i[ show edit update destroy ]

  # GET /interactions or /interactions.json
  def index
    @interactions = current_user.interactions

  end

  # GET /interactions/1 or /interactions/1.json
  def show
    @interaction = Interaction.find(params[:id])
  end

  # GET /interactions/new
  def new
    @contacts = current_user.contacts
    @locations = current_user.locations.uniq
    @interaction_types = InteractionType.all
    @interaction_categories = InteractionCategory.all
    @emotional_reactions = EmotionalReaction.all
    @interaction = Interaction.new
  end

  # GET /interactions/1/edit
  def edit
      @contacts = current_user.contacts
      @locations = current_user.locations
      @interaction = Interaction.find(params[:id])
      @interaction_types = InteractionType.all
      @interaction_categories = InteractionCategory.all
      @emotional_reactions = EmotionalReaction.all
  end

  # POST /interactions or /interactions.json
  def create
    @interaction = current_user.interactions.new(interaction_params)
    @contacts = current_user.contacts
    @locations = current_user.locations

    respond_to do |format|
      if @interaction.save
        @interaction.update_points
        @interaction.contact.update_points
        format.html { redirect_to interaction_url(@interaction), 
          notice: "Interaction was successfully created." }
        format.json { render :show, status: :created, location: @interaction }
        logger.info @interaction.errors.full_messages
      else
        @interaction_types = InteractionType.all
        @interaction_categories = InteractionCategory.all
        @emotional_reactions = EmotionalReaction.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interactions/1 or /interactions/1.json
  def update
    respond_to do |format|
      if @interaction.update(interaction_params)
        @interaction.update_points
        @interaction.contact.update_points
        format.html { redirect_to interaction_url(@interaction), 
          notice: "Interaction was successfully updated." }
        format.json { render :show, status: :ok, location: @interaction }
      else
        @interaction_types = InteractionType.all
        @interaction_categories = InteractionCategory.all
        @emotional_reactions = EmotionalReaction.all
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
      params.require(:interaction).permit(
        :name, :description, :contact_id, :date, :length, :location_id,
        :i_initiated, :user_id, :interaction_type_id, :you_initiated_contact,
        interaction_category_ids: [], emotional_reaction_ids: []
      )
    end

end
