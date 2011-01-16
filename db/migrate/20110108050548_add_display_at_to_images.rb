class AddDisplayAtToImages < ActiveRecord::Migration
  def self.up
    add_column :images,:display_at,:datetime
  end

  def self.down
    remove_column :images,:display_at
  end
end
