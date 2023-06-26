class AddUseridToMntevent < ActiveRecord::Migration[7.0]
  def change
    add_reference :mntevents, :user, foreign_key: true
  end
end
