# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  body        :text
#  point       :integer
#  user_id     :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :user, optional: true, inverse_of: :posts
  belongs_to :category
  has_many :comments

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :body, presence: true
  validates :point, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
end
