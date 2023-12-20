class EmotionalReactionsController < ApplicationController
  before_action :set_emotional_reaction, only: %i[ show edit update destroy ]

  # GET /emotional_reactions or /emotional_reactions.json
  def index
    @emotional_reactions = EmotionalReaction.all
  end

  # GET /emotional_reactions/1 or /emotional_reactions/1.json
  def show
  end

  # GET /emotional_reactions/new
  def new
    @emotional_reaction = EmotionalReaction.new
  end

  # GET /emotional_reactions/1/edit
  def edit
  end

  # POST /emotional_reactions or /emotional_reactions.json
  def create
    @emotional_reaction = EmotionalReaction.new(emotional_reaction_params)

    respond_to do |format|
      if @emotional_reaction.save
        format.html { redirect_to emotional_reaction_url(@emotional_reaction), notice: "Emotional reaction was successfully created." }
        format.json { render :show, status: :created, location: @emotional_reaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @emotional_reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emotional_reactions/1 or /emotional_reactions/1.json
  def update
    respond_to do |format|
      if @emotional_reaction.update(emotional_reaction_params)
        format.html { redirect_to emotional_reaction_url(@emotional_reaction), notice: "Emotional reaction was successfully updated." }
        format.json { render :show, status: :ok, location: @emotional_reaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @emotional_reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emotional_reactions/1 or /emotional_reactions/1.json
  def destroy
    @emotional_reaction.destroy

    respond_to do |format|
      format.html { redirect_to emotional_reactions_url, notice: "Emotional reaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emotional_reaction
      @emotional_reaction = EmotionalReaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def emotional_reaction_params
      params.require(:emotional_reaction).permit(:name, :description)
    end
end