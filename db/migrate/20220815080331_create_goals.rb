class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string     :theme              ,null: false
      t.string     :purpose            ,null: false
      t.integer    :target_total_time  ,null: false
      t.references :user               ,null: false ,foreign_key: true
      t.timestamps
    end
  end
end
