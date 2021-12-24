# frozen_string_literal: true

class User < ApplicationRecord
  validate :image_file_type_check
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  private

  def image_file_type_check
    return unless avatar.attached?

    errors.add(:avatar, I18n.t('errors.messages.file_type_not_image')) unless image_file?
  end

  def image_file?
    %(image/jpg image/jpeg image/gif image/png).include?(avatar.content_type)
  end
end
