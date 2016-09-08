require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "valid? returns true" do
    assert build(:task).valid?
  end

  test "valid? returns false" do
  	refute build(:task, title: nil).valid?
  	refute build(:task, title: "t" * 51).valid?
  	refute build(:task, plan_time: "").valid?
  	refute build(:task, actual_time: "").valid?
  	refute build(:task, memo: "a" * 201).valid?
  	refute build(:task, importance: 101).valid?
  	refute build(:task, importance: "").valid?
  	refute build(:task, urgency: 101).valid?
  	refute build(:task, urgency: "").valid?
  end
end
