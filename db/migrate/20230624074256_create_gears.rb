class CreateGears < ActiveRecord::Migration[7.0]
  def change
    create_table :gears do |t|
      t.references :mntevents, foreign_key: true
      t.string :name
      t.integer :weight

      t.timestamps
    end
  end
end
