class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :plan_time, numericality: { only_integer: true }, allow_blank: true
  validates :actual_time, numericality: { only_integer: true }, allow_blank: true
  validates :memo, length: { maximum: 200 }, allow_blank: true
  validates :importance, numericality: { less_than_or_equal_to: 100 }
  validates :urgency, numericality: { less_than_or_equal_to: 100 }

  enum progress: [:plan, :doing, :done]
  enum frequency: [:today, :every_week, :every_day]

  scope :today, -> { where(date: Date.now) }
  scope :high_priority, -> { where(:urgency > 50).order_by(importance) }
  scope :row_priority, -> { where(:urgency <= 50).order_by(importance) }
end
