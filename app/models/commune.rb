class Commune < ApplicationRecord
  belongs_to :province
  
  validates :name, presence: true
end
