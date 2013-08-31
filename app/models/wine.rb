# == Schema Information
#
# Table name: wines
#
#  id          :integer          not null, primary key
#  varietal    :string(255)
#  country     :string(255)
#  vintage     :integer
#  description :string(255)
#  price       :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Wine < ActiveRecord::Base

	VALID_PRICE_REGEX = /\d+(,\d{1,2})?/
	attr_accessible :varietal, :country, :vintage, :description, :price

	validates :varietal, presence: true, length: { maximum: 75 }
# It may be a blend with a number of varietals strung together.
	validates :country, presence: true, length: { maximum: 20 }
	validates :description, presence: true, length: { maximum: 200 }
	validates :price, presence: true, 
						format: { with: VALID_PRICE_REGEX },
						numericality: { greater_than_or_equal_to: 0.01 }
end



