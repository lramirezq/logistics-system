class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Company.clients.main_companies.active.includes(:subclients, :client_providers, :contacts)
    @providers = Company.providers.active.includes(:contacts)
  end

  def show
    @contacts = @company.contacts.active
    @subclients = @company.subclients.active if @company.client?
    @providers = @company.client_providers.active if @company.client?
  end

  def new
    @company = Company.new
    @parent_id = params[:parent_id]
    @relationship_type = params[:relationship_type]
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
      # Crear relación si viene de un cliente padre
      if params[:parent_id].present? && params[:relationship_type].present?
        parent_client = Company.find(params[:parent_id])
        CompanyRelationship.create!(
          client: parent_client,
          related_company: @company,
          relationship_type: params[:relationship_type]
        )
        redirect_to parent_client, notice: "#{params[:relationship_type] == 'provider' ? 'Proveedor' : 'Subcliente'} creado exitosamente."
      else
        redirect_to @company, notice: 'Empresa creada exitosamente.'
      end
    else
      @parent_id = params[:parent_id]
      @relationship_type = params[:relationship_type]
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Empresa actualizada exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @company.update(active: false)
    redirect_to companies_path, notice: 'Empresa desactivada exitosamente.'
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :company_type, :tax_id, :address, :phone, :email, :parent_id, :country, :region, :province, :commune, :codigo, :razon_social, :nombre_comercial, :tipo_empresa)
  end
end