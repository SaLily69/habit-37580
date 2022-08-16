class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string     :theme              ,null: false
      t.string     :purpose            ,null: false
      t.time       :target_total_time
      t.references :user               ,null: false ,foreign_key: true
      t.timestamps
    end
  end
end
