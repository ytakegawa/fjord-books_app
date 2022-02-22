# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
end
