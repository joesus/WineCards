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
#  name        :string(255)
#  place       :string(255)
#  producer    :string(255)
#

class Wine < ActiveRecord::Base
	has_many :comments

	VALID_PRICE_REGEX = /\d+(,\d{1,2})?/
	attr_accessible :name, :producer, :varietal, :country, :vintage, :description,
								  :price, :place

	validates :name, length: { maximum: 125 }
	validates :varietal, presence: true, length: { maximum: 75 }
# It may be a blend with a number of varietals strung together.
	validates :country, presence: true, length: { maximum: 20 }
	validates :description, presence: true, length: { maximum: 500 }
	validates :price, presence: true, 
						format: { with: VALID_PRICE_REGEX },
						numericality: { greater_than_or_equal_to: 0.01 }
	validates :place, presence: true, length: { maximum: 75 }
	validates :producer, length: { maximum: 75 }
end

# Figure out what validations to pass to producer. 
