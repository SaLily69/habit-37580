class Goal < ApplicationRecord
  belongs_to :user
  has_many   :logs, dependent: :destroy

  validates :theme,             presence: true
  validates :purpose,           presence: true
  validates :target_total_time, presence: true

end
