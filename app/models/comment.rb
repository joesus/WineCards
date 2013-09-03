# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  wine_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :wine

	default_scope -> { order('created_at DESC') }
	attr_accessible :content, :user_id, :wine_id
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 250 }

end
