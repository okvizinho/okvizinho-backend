class Space < ApplicationRecord
  belongs_to :city

  has_one_attached :cover_image

  enum kind: %i[parking storage]

  validates :title, :description, presence: true

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  def cover_image_url
    return unless cover_image.attached?

    ::Rails.application.routes.url_helpers.rails_blob_url(cover_image)
  end
end
