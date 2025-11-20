class Company < ApplicationRecord
  TYPES = %w[client provider].freeze
  TIPOS_EMPRESA = %w[SHIPPER CONSIGNATARIO AGENTE COMPANIA NAVIERA MULTIPLE].freeze

  # Relaciones
  has_many :contacts, dependent: :destroy
  
  # Relaciones como cliente principal
  has_many :client_relationships, class_name: 'CompanyRelationship', foreign_key: 'client_id', dependent: :destroy
  has_many :subclients, -> { where(company_relationships: { relationship_type: 'subclient' }) }, 
           through: :client_relationships, source: :related_company
  has_many :client_providers, -> { where(company_relationships: { relationship_type: 'provider' }) }, 
           through: :client_relationships, source: :related_company
  
  # Relaciones como empresa relacionada
  has_many :related_relationships, class_name: 'CompanyRelationship', foreign_key: 'related_company_id', dependent: :destroy
  has_many :parent_clients, through: :related_relationships, source: :client

  # Validaciones
  validates :name, presence: true
  validates :company_type, presence: true, inclusion: { in: TYPES }
  validates :tipo_empresa, presence: true, inclusion: { in: TIPOS_EMPRESA }
  validates :codigo, uniqueness: true, allow_blank: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  # Scopes
  scope :active, -> { where(active: true) }
  scope :clients, -> { where(company_type: 'client') }
  scope :providers, -> { where(company_type: 'provider') }
  scope :main_companies, -> { joins('LEFT JOIN company_relationships ON companies.id = company_relationships.related_company_id').where(company_relationships: { id: nil }) }

  # Métodos
  def client?
    company_type == 'client'
  end

  def provider?
    company_type == 'provider'
  end
  
  def add_subclient(company)
    client_relationships.create(related_company: company, relationship_type: 'subclient')
  end
  
  def add_provider(company)
    client_relationships.create(related_company: company, relationship_type: 'provider')
  end
end
