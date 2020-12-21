require 'carrierwave/orm/activerecord'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :children, class_name: "User", foreign_key: "parent_id"
  belongs_to :parent, class_name: "User"

  validate :check_user_role_validation


  private

  def check_user_role_validation
    self.errors.add_to_base("you are not allowed to update unknown columns") if ((self.is_admin && (self.id == self.parent_id && check_changed_attributes(['phone_number']).length != 0)) || (self.is_admin && check_changed_attributes(['phone_number', 'address_line', 'street', 'city', 'state', 'pin_code', 'landmark']).length != 0) || (check_changed_attributes(['avatar', 'phone_number', 'address_line', 'street', 'city', 'state', 'pin_code', 'landmark']).length != 0))
  end

  def check_changed_attributes(attrs)
    all_changed_attributes = self.changes.keys - ['parent_id']

    if all_changed_attributes.delete('address') == 'address'
      old_values, new_values = self.changes['address']
      old_values.each do |key, value|
        all_changed_attributes.push(key) if new_values[key] != value
      end
    end

    all_changed_attributes - attrs
  end
end
