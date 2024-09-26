# == Schema Information
#
# Table name: blogs
#
#  id         :bigint           not null, primary key
#  title      :text             not null
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Blog < ApplicationRecord
  validates_presence_of :title, :body
end
