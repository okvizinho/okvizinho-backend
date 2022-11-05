class Place < ApplicationRecord
  belongs_to :city
  has_many :spaces
  
  has_one_attached :cover_image
  
  validates :title, :description, presence: true

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  def cover_image_url
    return unless cover_image.attached?

    ::Rails.application.routes.url_helpers.rails_blob_url(cover_image)
  end
end
