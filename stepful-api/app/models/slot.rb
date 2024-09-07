class Slot < ApplicationRecord
  DEFAULT_LENGTH = 2.hours

  belongs_to :coach
  belongs_to :student, optional: true

  validates :length, comparison: { equal_to: DEFAULT_LENGTH }

  def start
    duration.begin
  end

  def end
    duration.end
  end

  def length
    duration.end - duration.begin
  end
end
