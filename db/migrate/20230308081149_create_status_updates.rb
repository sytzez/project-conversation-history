class CreateStatusUpdates < ActiveRecord::Migration[7.0]
  def change
    create_table :status_updates do |t|
      t.integer :status
    end
  end
end
