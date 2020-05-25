# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  description :string
#  status      :string           default("active"), not null
#  title       :string
#  views       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  home_id     :bigint
#  user_id     :integer          not null
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
