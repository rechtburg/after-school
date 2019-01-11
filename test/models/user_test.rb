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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
