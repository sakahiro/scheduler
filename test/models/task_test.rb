require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "valid? returns true" do
    assert build(:task).valid?
  end

  test "valid? returns false" do
    refute build(:task, title: nil).valid?
    refute build(:task, title: "t" * 51).valid?
    refute build(:task, date: nil).valid?
    refute build(:task, memo: "a" * 201).valid?
    refute build(:task, importance: 101).valid?
    refute build(:task, urgency: 101).valid?
  end

  test ".today" do
    today_task = create(:task)
    high_priority_today_task = create(:task, urgency: 100)
    not_today_task = create(:task, date: Date.tomorrow)
    assert_equal(Task.today, [high_priority_today_task, today_task])
  end

  test ".not_today" do
    today_task = create(:task)
    tommorow_task = create(:task, date: Date.tomorrow)
    day_after_tommorow_task = create(:task, date: Date.tomorrow + 1)
    assert_equal(Task.not_today, [tommorow_task, day_after_tommorow_task])
  end

  test ".high_priority" do
    high_priority_task = create(:task, urgency: 51)
    row_priority_task = create(:task)
    assert_equal(Task.high_priority, [high_priority_task])
  end

  test ".row_priority" do
    high_priority_task = create(:task, urgency: 51)
    row_priority_task = create(:task)
    assert_equal(Task.row_priority, [row_priority_task])
  end

  test ".done" do
    done_task = create(:task, actual_time: 1)
    doing = create(:task)
    assert_equal(Task.done, [done_task])
  end

  test ".doing" do
    done_task = create(:task, actual_time: 1)
    doing = create(:task)
    assert_equal(Task.doing, [doing])
  end
end
