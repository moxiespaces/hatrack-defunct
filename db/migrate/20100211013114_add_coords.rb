class AddCoords < ActiveRecord::Migration
  def self.up
    add_column :black_hats, :left, :integer, :defualt => 0
    add_column :black_hats, :top, :integer, :defualt => 0
    add_column :yellow_hats, :left, :integer,  :defualt => 0
    add_column :yellow_hats, :top, :integer,  :defualt => 0

  end

  def self.down
    remove_column :black_hats, :left
    remove_column :black_hats, :top
    remove_column :yellow_hats, :left
    remove_column :yellow_hats, :top
  end
end
