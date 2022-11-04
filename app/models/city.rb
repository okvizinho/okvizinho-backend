class City < ApplicationRecord
  has_many :spaces
  
  validates :name, :uf, presence: true

  scope :active, -> { where(is_active: true) }

  scope :inactive, -> { where!(is_active: nil).or(City.where(is_active: false)) }

end
