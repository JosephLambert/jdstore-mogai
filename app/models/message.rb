# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ApplicationRecord
 end
