class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]
  before_action :set_last_known_countries, only: [:new, :edit, :update, :create]
  before_action :set_last_known_cities, only: [:new, :edit, :update, :create]

  include Pagy::Backend

  # GET /contacts or /contacts.json
  
  def index
    @contacts = current_user.contacts
    @contact_groups = current_user.contact_groups
    @contact_types = current_user.contact_types

    #Ransack variables for search
    @query = @contacts.ransack(params[:q])
    @results = @query.result(distinct: true)  
  end

  def all_contacts
    @pagy, @contacts = pagy(current_user.contacts, items: 25)
    @contact_groups = current_user.contact_groups
    @contact_types = current_user.contact_types
  end

  # GET /contacts/1 or /contacts/1.json
  def show
    @contact = Contact.find(params[:id])
    @interactions = current_user.interactions.where(contact: @contact).order(date: :DESC)
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    @contact_groups = current_user.contact_groups
    @contact_types = current_user.contact_types
    @last_known_cities = current_user.last_known_cities
    @last_known_countries = current_user.last_known_countries
  end

  # GET /contacts/1/edit
  def edit
    @contact_groups = current_user.contact_groups
    @contact_types = current_user.contact_types
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contact_url(@contact), notice: "Contact was successfully created." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contact_url(@contact), notice: "Contact was successfully updated." }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url, notice: "Contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def set_last_known_countries
      @last_known_countries = LastKnownCountry.all
    end

    def set_last_known_cities
      @last_known_cities = LastKnownCity.all
    end    

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, 
                                      :mobile_phone_1, :mobile_phone_2, 
                                      :office_phone_1, :office_phone_2, :home_phone, 
                                      :other_phone, :email_1, :email_2, :email_3, 
                                      :email_4, :email_5, :website_1, :website_2, 
                                      :website_3, :website_4, :website_5, :website_6, 
                                      :website_7, :website_8, :contact_apps, :birthday, 
                                      :address_1, :address_2, :how_we_met, :things_I_like, 
                                      :best_memories, :areas_for_improvement, :notes, :points,
                                      :date_first_met,
                                      category_ids:[], contact_group_ids:[], contact_type_ids:[],
                                      last_known_country_ids:[], last_known_city_ids:[])
    end
end
