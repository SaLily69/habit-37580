class Log < ApplicationRecord
  belongs_to :goal

  validates :study_day,     presence: true
  validates :study_hour,    presence: true, numericality: {only_integer: true, less_than_or_equal_to: 23}
  validates :study_minute,  presence: true, numericality: {only_integer: true, less_than_or_equal_to: 59}
  validates :study_minute,  presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 59}, if: :input_study_hour?
  def input_study_hour?
    study_hour == 0
  end
  validates :feed_back,     presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :time_remind,   presence: true
  validates :goal_id,       presence: true

end
