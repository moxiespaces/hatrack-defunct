class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.timestamps
      t.integer :user_id
    end
  end

  def self.down
  end
end
