class CreateClimbs < ActiveRecord::Migration
  def change
    create_table :climbs do |t|
      t.string :name
      t.string :grade
      t.float :rating

      t.timestamps
    end
  end
end
