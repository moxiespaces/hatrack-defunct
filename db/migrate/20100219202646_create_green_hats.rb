class CreateGreenHats < ActiveRecord::Migration
  def self.up
    create_table :green_hats do |t|
      t.text :body
      t.integer :hat_id
      t.timestamps
    end
  end

  def self.down
    drop_table :green_hats
  end
end
