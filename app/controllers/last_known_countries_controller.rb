class LastKnownCountriesController < ApplicationController
  before_action :set_last_known_country, only: %i[ show edit update destroy ]

  include Pagy::Backend

  # GET /last_known_countries or /last_known_countries.json
  def index
    @last_known_countries = current_user.last_known_countries
  end

  # GET /last_known_countries/1 or /last_known_countries/1.json
  def show
  end

  # GET /last_known_countries/new
  def new
    @last_known_country = LastKnownCountry.new
  end

  # GET /last_known_countries/1/edit
  def edit
  end

  # POST /last_known_countries or /last_known_countries.json
  def create
    @last_known_country = current_user.last_known_countries.new(last_known_country_params)

    respond_to do |format|
      if @last_known_country.save
        format.html { redirect_to last_known_country_url(@last_known_country), notice: "Last known country was successfully created." }
        format.json { render :show, status: :created, location: @last_known_country }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @last_known_country.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /last_known_countries/1 or /last_known_countries/1.json
  def update
    respond_to do |format|
      if @last_known_country.update(last_known_country_params)
        format.html { redirect_to last_known_country_url(@last_known_country), notice: "Last known country was successfully updated." }
        format.json { render :show, status: :ok, location: @last_known_country }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @last_known_country.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /last_known_countries/1 or /last_known_countries/1.json
  def destroy
    @last_known_country.destroy

    respond_to do |format|
      format.html { redirect_to last_known_countries_url, notice: "Last known country was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_last_known_country
      @last_known_country = LastKnownCountry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def last_known_country_params
      params.require(:last_known_country).permit(:name)
    end
end
