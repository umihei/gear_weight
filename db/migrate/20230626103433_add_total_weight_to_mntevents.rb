class AddTotalWeightToMntevents < ActiveRecord::Migration[7.0]
  def change
    add_column :mntevents, :total_weight, :integer, default: 0
  end
end
