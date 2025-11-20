class CompanyRelationship < ApplicationRecord
  RELATIONSHIP_TYPES = %w[subclient provider].freeze
  
  belongs_to :client, class_name: 'Company'
  belongs_to :related_company, class_name: 'Company'
  
  validates :relationship_type, presence: true, inclusion: { in: RELATIONSHIP_TYPES }
  validates :client_id, uniqueness: { scope: [:related_company_id, :relationship_type] }
  
  scope :subclients, -> { where(relationship_type: 'subclient') }
  scope :providers, -> { where(relationship_type: 'provider') }
end
