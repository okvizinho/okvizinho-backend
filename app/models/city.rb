class City < ApplicationRecord

  validates :name, :uf, presence: true

  scope :active, -> { where(is_active: true) }
end
