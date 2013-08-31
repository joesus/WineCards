FactoryGirl.define do
	factory :user do
		name			"Joe S"
		email			"joe@example.com"
		password	"foobar"
		password_confirmation "foobar"
	end

	factory :wine do
		varietal		"grape"
		country			"Wineland"
		vintage			2000
		description "tasty"
		price				{ 10 + rand(100) }
	end
end

# By passing :user to the factory we tell the factory that the subsequent
# definition is for a User model object, same with :wine. 

