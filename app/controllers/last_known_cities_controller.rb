class LastKnownCitiesController < ApplicationController
  before_action :set_last_known_city, only: %i[ show edit update destroy ]

  include Pagy::Backend

  # GET /last_known_cities or /last_known_cities.json
  def index
    @last_known_cities = current_user.last_known_cities
  end

  # GET /last_known_cities/1 or /last_known_cities/1.json
  def show
  end

  # GET /last_known_cities/new
  def new
    @last_known_city = LastKnownCity.new
  end

  # GET /last_known_cities/1/edit
  def edit
  end

  # POST /last_known_cities or /last_known_cities.json
  def create
    @last_known_city = current_user.last_known_cities.new(last_known_city_params)

    respond_to do |format|
      if @last_known_city.save
        format.html { redirect_to last_known_city_url(@last_known_city), notice: "Last known city was successfully created." }
        format.json { render :show, status: :created, location: @last_known_city }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @last_known_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /last_known_cities/1 or /last_known_cities/1.json
  def update
    respond_to do |format|
      if @last_known_city.update(last_known_city_params)
        format.html { redirect_to last_known_city_url(@last_known_city), notice: "Last known city was successfully updated." }
        format.json { render :show, status: :ok, location: @last_known_city }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @last_known_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /last_known_cities/1 or /last_known_cities/1.json
  def destroy
    @last_known_city.destroy

    respond_to do |format|
      format.html { redirect_to last_known_cities_url, notice: "Last known city was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_last_known_city
      @last_known_city = LastKnownCity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def last_known_city_params
      params.require(:last_known_city).permit(:name)
    end
end
