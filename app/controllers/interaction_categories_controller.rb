class InteractionCategoriesController < ApplicationController
  before_action :set_interaction_category, only: %i[ show edit update destroy ]

  # GET /interaction_categories or /interaction_categories.json
  def index
    @interaction_categories = InteractionCategory.all
  end

  # GET /interaction_categories/1 or /interaction_categories/1.json
  def show
  end

  # GET /interaction_categories/new
  def new
    @interaction_category = InteractionCategory.new
  end

  # GET /interaction_categories/1/edit
  def edit
  end

  # POST /interaction_categories or /interaction_categories.json
  def create
    @interaction_category = InteractionCategory.new(interaction_category_params)

    respond_to do |format|
      if @interaction_category.save
        format.html { redirect_to interaction_category_url(@interaction_category), notice: "Interaction category was successfully created." }
        format.json { render :show, status: :created, location: @interaction_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @interaction_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interaction_categories/1 or /interaction_categories/1.json
  def update
    respond_to do |format|
      if @interaction_category.update(interaction_category_params)
        format.html { redirect_to interaction_category_url(@interaction_category), notice: "Interaction category was successfully updated." }
        format.json { render :show, status: :ok, location: @interaction_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interaction_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interaction_categories/1 or /interaction_categories/1.json
  def destroy
    @interaction_category.destroy

    respond_to do |format|
      format.html { redirect_to interaction_categories_url, notice: "Interaction category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interaction_category
      @interaction_category = InteractionCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def interaction_category_params
      params.require(:interaction_category).permit(:name, :description)
    end
end
