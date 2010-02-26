class CreateHats < ActiveRecord::Migration
  def self.up
    create_table :hats do |t|
      t.text :type
      t.text :body
      t.integer :hat_id, :null => true
      t.timestamps
    end
  end

  def self.down
    drop_table :hats
  end
end
