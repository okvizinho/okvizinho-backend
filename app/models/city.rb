class City < ApplicationRecord
  has_many :spaces
  
  validates :name, :uf, presence: true

  scope :active, -> { where(is_active: true) }
end
