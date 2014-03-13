class CreateAscents < ActiveRecord::Migration
  def change
    create_table :ascents do |t|
      t.integer :user_id
      t.integer :climb_id

      t.timestamps
    end
  end
end
