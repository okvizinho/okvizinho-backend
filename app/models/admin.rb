class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :active, -> { where(is_active: true) }

  scope :inactive, -> { where!(is_active: nil).or(Admin.where(is_active: false)) }
end
