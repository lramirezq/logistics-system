class OperationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_operation, only: [:show, :edit, :update, :destroy]
  before_action :load_companies, only: [:new, :create, :edit, :update]

  def index
    @operations = Operation.includes(:shipper, :consignatario, :ref_cliente, :agente, :compania)
                           .order(created_at: :desc)
  end

  def show
  end

  def new
    @operation = Operation.new
    @operation.fecha = Date.current
  end

  def create
    @operation = Operation.new(operation_params)
    
    if @operation.save
      redirect_to @operation, notice: 'Operación creada exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @operation.update(operation_params)
      redirect_to @operation, notice: 'Operación actualizada exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @operation.destroy
    redirect_to operations_path, notice: 'Operación eliminada exitosamente.'
  end

  private

  def set_operation
    @operation = Operation.find(params[:id])
  end

  def load_companies
    @shippers = Company.where(tipo_empresa: 'SHIPPER')
    @consignatarios = Company.where(tipo_empresa: 'CONSIGNATARIO')
    @clientes = Company.all
    @agentes = Company.where(tipo_empresa: 'AGENTE')
    @companias = Company.where(tipo_empresa: 'COMPANIA')
  end

  def operation_params
    params.require(:operation).permit(
      :tipo_operacion, :fecha, :shipper_id, :consignatario_id, :ref_cliente_id,
      :emisor_master, :vessel_vuelo, :etd, :eta, :origen, :destino,
      :agente_id, :compania_id, :naviera, :numero_contenedor, :volumen, :peso,
      :bl_master, :bl_hijo, :fact_afecta, :fact_exenta, :fact_extranj,
      :compra_afecta, :compra_exenta, :observaciones
    )
  end
end