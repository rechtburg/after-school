# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string           default(""), not null
#  password_digest :string(191)      not null
#  remember_token  :string(191)
#  university      :integer
#  faculty         :integer
#  major           :string
#  point           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  image           :string
#

class User < ApplicationRecord
  has_secure_password validations: true

  has_many :posts
  has_many :comments

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true

  mount_uploader :image, ImageUploader

  enum university: [:UTokyo, :Waseda, :Keio, :UTT, :Hitotsubashi,
                          :Jochi, :Meiji, :Aoyama, :Rikkyo, :Chuo, :Housei, :ICU]
  
  enum faculty: [:Engineering, :Law, :Literature, :Economics, :Medical, :Science, :Medichine, :Agriculture]

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
end
