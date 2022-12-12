class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.date        :study_day,     null: false
      t.integer     :study_hour,    null: false
      t.integer     :study_minute,  null: false
      t.text        :task
      t.integer     :feed_back,     null: false
      t.datetime    :time_remind,   null: false
      t.references  :goal,          null: false ,foreign_key: true

      t.timestamps
    end
  end
end
