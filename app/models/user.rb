# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :active_follow, class_name: 'Follow',
                           foreign_key: 'follower_id',
                           dependent: :destroy
  has_many :passive_follow, class_name: 'Follow',
                            foreign_key: 'followed_id',
                            dependent: :destroy
  has_many :following, through: :active_follow, source: :followed
  has_many :followers, through: :passive_follow
  has_one_attached :avatar

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_follow.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
