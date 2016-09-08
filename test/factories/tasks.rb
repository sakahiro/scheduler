FactoryGirl.define do
	factory :task do
		title "t" * 50
		date Date.today
		plan_time 10
		actual_time 10
		memo "a" * 200
	end
end