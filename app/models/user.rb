class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  validates :username, uniqueness: true
  validate :username_without_spaces

  def username_without_spaces
    regex_validate = username.match(/^\S*$/)

    unless regex_validate.present?
      errors.add(:base, 'Username without spaces')
      throw(:abort)
    end
  end

  def follow?(user)
    followees.find(user.id).present? rescue nil
  end
end
