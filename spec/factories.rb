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

	factory :wine do
	  sequence(:varietal) { |n| "Grape #{n}"}
		sequence(:country)	{ |n| "#{n}-Landia"}
		sequence(:place)		{ |n| "Napa-#{n}"}
		name				{ "Proprietary Blend" }
		vintage			{ 2000 + rand(10) }
		description { "tasty" }
		price				{ 10 + rand(100) }
		producer 		{ "Sbragia Vineyards" }
		category		{ "Spain"}
	end

	factory :comment do
		content "Smoky and Oaky Nose"
		user
	end
end

# By passing :user to the factory we tell the factory that the subsequent
# definition is for a User model object, same with :wine. 

