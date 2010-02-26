class DropYellowAndBlackAndOtherStuff < ActiveRecord::Migration
  def self.up
    drop_table :yellow_hats
    drop_table :black_hats
    add_column :hats, :green_hat_id, :integer
    remove_column :hats, :hat_id
  end

  def self.down
  end
end
