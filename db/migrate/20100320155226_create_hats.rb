class CreateHats < ActiveRecord::Migration
  def self.up
    create_table :yellow_hats do |t|
      t.string :text
      t.integer :sprint_id
      t.timestamps
    end

    create_table :black_hats do |t|
      t.string :text
      t.integer :sprint_id
      t.integer :promotions
      t.timestamps
    end

    create_table :green_hats do |t|
      t.string :text
      t.integer :black_hat_id
      t.timestamps
    end
  end

  def self.down
  end
end
