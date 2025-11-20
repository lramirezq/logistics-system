class ContactsController < ApplicationController
  before_action :set_company
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @contact = @company.contacts.build
  end

  def create
    @contact = @company.contacts.build(contact_params)
    
    if @contact.save
      redirect_to @company, notice: 'Contacto creado exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to @company, notice: 'Contacto actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @contact.update(active: false)
    redirect_to @company, notice: 'Contacto desactivado exitosamente.'
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_contact
    @contact = @company.contacts.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :position, :phone, :email)
  end
end