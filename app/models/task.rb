class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :date, presence: true
  validates :plan_time, numericality: { only_integer: true }, allow_blank: true
  validates :actual_time, numericality: { only_integer: true }, allow_blank: true
  validates :memo, length: { maximum: 200 }, allow_blank: true
  validates :importance, numericality: { less_than_or_equal_to: 100 }
  validates :urgency, numericality: { less_than_or_equal_to: 100 }

  enum progress: [:planed, :doing, :done, :sent]
  enum frequency: [:today, :every_week, :every_day]
  enum purpose: [:work, :challenge, :study]

  scope :today, -> { where(date: Date.current).order(urgency: :desc) }
  scope :not_today, -> { where.not(date: Date.current).order(:date) }
  scope :high_priority, -> { where("urgency > 50") }
  scope :row_priority, -> { where("urgency <= 50") }
  scope :planed, -> { where(progress: :planed) }
  scope :doing, -> { where(progress: :doing) }
  scope :done, -> { where(progress: :done) }
  scope :sent, -> { where(progress: :sent) }
  scope :not_finished, -> { planed.or(doing) }
  scope :finished, -> { done.or(sent)}
end
