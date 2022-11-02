class Space < ApplicationRecord
  belongs_to :city

  enum kind: %i[parking storage]

  validates :title, :description, presence: true

  scope :active, -> { where(is_active: true) }
end
