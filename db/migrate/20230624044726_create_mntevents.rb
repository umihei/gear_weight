class CreateMntevents < ActiveRecord::Migration[7.0]
  def change
    create_table :mntevents do |t|
      t.string :eventname
      t.date :eventdate
      t.string :mnt
      t.text :memo

      t.timestamps
    end
  end
end
