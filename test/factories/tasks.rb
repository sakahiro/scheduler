FactoryGirl.define do
  factory :task do
    title "t" * 50
    date Date.current
    plan_time 10
    actual_time nil
    memo "a" * 200
    purpose :work
  end
end