class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :date, presence: true
  validates :plan_time, numericality: { only_integer: true }, allow_blank: true
  validates :actual_time, numericality: { only_integer: true }, allow_blank: true
  validates :memo, length: { maximum: 200 }, allow_blank: true
  validates :importance, numericality: { less_than_or_equal_to: 100 }
  validates :urgency, numericality: { less_than_or_equal_to: 100 }

  enum progress: [:plan, :doing, :done, :sent]
  enum frequency: [:today, :every_week, :every_day]

  scope :today, -> { where(date: Date.current).order(urgency: :desc) }
  scope :not_today, -> { where.not(date: Date.current).order(:date) }
  scope :high_priority, -> { where("urgency > 50") }
  scope :row_priority, -> { where("urgency <= 50") }
  scope :done, -> { where.not(actual_time: nil) }
  scope :doing, -> { where(actual_time: nil) }
end
