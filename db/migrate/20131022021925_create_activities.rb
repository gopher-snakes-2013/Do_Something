class CreateActivities < ActiveRecord::Migration
  def up
    create_table :activities do |t|
      t.string :title
      t.string :city
      t.string :cost
      t.string :category
      t.string :comment
      t.string :rating

      t.timestamps
    end
  end

  def down
    drop_table :activities
  end
end
