class Operation < ApplicationRecord
  belongs_to :shipper, class_name: 'Company', optional: true
  belongs_to :consignatario, class_name: 'Company', optional: true
  belongs_to :ref_cliente, class_name: 'Company', optional: true
  belongs_to :agente, class_name: 'Company', optional: true
  belongs_to :compania, class_name: 'Company', optional: true
  
  validates :numero_operacion, presence: true, uniqueness: true
  validates :tipo_operacion, presence: true
  validates :fecha, presence: true
  
  before_validation :set_numero_operacion, on: :create
  
  TIPOS_OPERACION = [
    'Importación',
    'Exportación',
    'Tránsito',
    'Cabotaje'
  ].freeze
  
  private
  
  def set_numero_operacion
    return if numero_operacion.present?
    
    last_operation = Operation.order(:numero_operacion).last
    self.numero_operacion = last_operation ? last_operation.numero_operacion + 1 : 1
  end
end
