class Log < ApplicationRecord
  belongs_to :goal

  validates :study_day,     presence: true
  validates :study_hour,    presence: true
  validates :study_minute,  presence: true
  validates :feed_back,     presence: true
  validates :time_remind,   presence: true
  validates :goal_id,       presence: true

end
