class ContactTypesController < ApplicationController
  before_action :set_contact_type, only: %i[ show edit update destroy ]

  include Pagy::Backend

  # GET /contact_types or /contact_types.json
  def index
    @pagy, @contact_types = pagy(current_user.contact_types, items: 25)
  end

  # GET /contact_types/1 or /contact_types/1.json
  def show
  end

  # GET /contact_types/new
  def new
    @contact_type = ContactType.new
  end

  # GET /contact_types/1/edit
  def edit
  end

  # POST /contact_types or /contact_types.json
  def create
    @contact_type = ContactType.new(contact_type_params)
    @contact_type.user = current_user

    respond_to do |format|
      if @contact_type.save
        format.html { redirect_to contact_type_url(@contact_type), notice: "Contact type was successfully created." }
        format.json { render :show, status: :created, location: @contact_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contact_types/1 or /contact_types/1.json
  def update
    respond_to do |format|
      if @contact_type.update(contact_type_params)
        format.html { redirect_to contact_type_url(@contact_type), notice: "Contact type was successfully updated." }
        format.json { render :show, status: :ok, location: @contact_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_types/1 or /contact_types/1.json
  def destroy
    @contact_type.destroy

    respond_to do |format|
      format.html { redirect_to contact_types_url, notice: "Contact type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_type
      @contact_type = ContactType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_type_params
      params.require(:contact_type).permit(:name)
    end
end
