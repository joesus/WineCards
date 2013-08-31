FactoryGirl.define do
	factory :user do
		sequence(:name) 		{ |n| "Person #{n}"}
		sequence(:email)		{ |n| "person_#{n}@example.com"}
		password "foobar"
		password_confirmation "foobar"
		
		factory :admin do
			admin true
		end
	end
end

	# factory :wine do
	#   sequence(:grape) { |n| "Grape #{n}"}
	# 	varietal		"grape"
	# 	country			"Wineland"
	# 	vintage			2000
	# 	description "tasty"
	# 	price				{ 10 + rand(100) }
	# end


# By passing :user to the factory we tell the factory that the subsequent
# definition is for a User model object, same with :wine. 

