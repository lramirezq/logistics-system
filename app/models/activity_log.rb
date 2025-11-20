class ActivityLog < ApplicationRecord
  belongs_to :user
  
  validates :action, presence: true
  validates :performed_at, presence: true
  
  scope :recent, -> { order(performed_at: :desc) }
  scope :by_user, ->(user) { where(user: user) }
  scope :by_action, ->(action) { where(action: action) }
  scope :by_resource, ->(type, id = nil) { where(resource_type: type, resource_id: id) }
  
  ACTIONS = {
    login: 'Inicio de sesión',
    logout: 'Cierre de sesión',
    create: 'Creación',
    update: 'Actualización',
    destroy: 'Eliminación',
    view: 'Visualización'
  }.freeze
  
  def self.log_activity(user, action, resource = nil, description = nil, request = nil)
    create!(
      user: user,
      action: action.to_s,
      resource_type: resource&.class&.name,
      resource_id: resource&.id,
      description: description || generate_description(action, resource),
      ip_address: request&.remote_ip,
      user_agent: request&.user_agent,
      performed_at: Time.current
    )
  end
  
  def action_name
    ACTIONS[action.to_sym] || action.humanize
  end
  
  def resource_name
    return resource_type if resource_id.blank?
    
    case resource_type
    when 'Company'
      Company.find_by(id: resource_id)&.nombre_comercial || "Empresa ##{resource_id}"
    when 'Operation'
      "Operación ##{Operation.find_by(id: resource_id)&.numero_operacion || resource_id}"
    when 'User'
      User.find_by(id: resource_id)&.name || "Usuario ##{resource_id}"
    else
      "#{resource_type} ##{resource_id}"
    end
  end
  
  private
  
  def self.generate_description(action, resource)
    case action.to_s
    when 'login'
      'Usuario inició sesión'
    when 'logout'
      'Usuario cerró sesión'
    when 'create'
      "Creó #{resource&.class&.name&.downcase || 'registro'}"
    when 'update'
      "Actualizó #{resource&.class&.name&.downcase || 'registro'}"
    when 'destroy'
      "Eliminó #{resource&.class&.name&.downcase || 'registro'}"
    when 'view'
      "Visualizó #{resource&.class&.name&.downcase || 'registro'}"
    else
      action.humanize
    end
  end
end