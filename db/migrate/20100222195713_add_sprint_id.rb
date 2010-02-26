class AddSprintId < ActiveRecord::Migration
  def self.up
    add_column :hats, :sprint_id, :integer
  end

  def self.down
    remove_column :hats, :sprint_id
  end
end
