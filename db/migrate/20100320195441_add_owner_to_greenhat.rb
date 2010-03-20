class AddOwnerToGreenhat < ActiveRecord::Migration
  def self.up
    add_column :green_hats, :owner, :string
  end

  def self.down
    remove_column :green_hats, :owner
  end
end
