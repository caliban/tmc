class AddDateToAscents < ActiveRecord::Migration
  def change
    add_column :ascents, :date, :date
    add_index :ascents, :date
  end
end
