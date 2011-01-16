class AddIndexToImages < ActiveRecord::Migration
  def self.up
    add_index :images,:display_at
  end

  def self.down
    remove_index :images,  :display_at
  end
end
