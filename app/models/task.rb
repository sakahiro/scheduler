class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :plan_time, numericality: { only_integer: true }
  validates :actual_time, numericality: { only_integer: true }
  validates :memo, length: { maximum: 200 }
  validates :importance, numericality: { less_than_or_equal_to: 100 }
  validates :urgency, numericality: { less_than_or_equal_to: 100 }

  enum progress: [:plan, :doing, :done]
  enum week: [:now, :every, :mon, :tues, :wed, :thurs, :fri, :sat, :san]

  scope :today, -> { where(date: Date.now) }
  scope :high_priority, -> { where(:urgency > 50).order_by(importance) }
  scope :row_priority, -> { where(:urgency <= 50).order_by(importance) }
end
