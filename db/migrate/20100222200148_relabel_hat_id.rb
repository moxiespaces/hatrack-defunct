class RelabelHatId < ActiveRecord::Migration
  def self.up
    add_column :green_hats, :black_hat_id, :integer
    remove_column :green_hats, :hat_id

  end

  def self.down
  end
end
