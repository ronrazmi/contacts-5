class ContactsController < ApplicationController
  def index
      @contacts = Contact.all
    end

    def show
      @contact = Contact.find_by(id: params[:id])
    end

    def new
    end

    def create
      coordinates = Geocoder.coordinates(params["address"])
      @contact = Contact.create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        phone: params[:phone],
        latitude: coordinates[0],
        longitude: coordinates[1]
      )
      flash[:success] = "Contact created."
      redirect_to "/contacts/#{@contact.id}"
    end

    def edit
      @contact = Contact.find_by(id: params[:id])
    end

    def update
      @contact = Contact.find_by(id: params[:id])
      @contact.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], phone: params[:phone])
      flash[:success] = "Contact updated."
      redirect_to "/contacts/#{@contact.id}"
    end

    def destroy
      @contact = Contact.find_by(id: params[:id])
      @contact.destroy
      flash[:success] = "Contact deleted."
      redirect_to "/"
    end

    def johns
      render 'johns.html.erb'
    end
end
