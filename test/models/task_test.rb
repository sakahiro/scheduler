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

  test "progress scope" do
    planed_task = create(:task, progress: 0)
    doing_task = create(:task, progress: 1)
    done_task = create(:task, progress: 2)
    sent_task = create(:task, progress: 3)
    assert_equal(Task.planed, [planed_task])
    assert_equal(Task.doing, [doing_task])
    assert_equal(Task.done, [done_task])
    assert_equal(Task.sent, [sent_task])
    assert_equal(Task.not_finished, [planed_task, doing_task])
    assert_equal(Task.finished, [done_task, sent_task])
  end
end
