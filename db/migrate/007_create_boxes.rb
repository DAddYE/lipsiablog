class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |t|
      t.string  :name
      t.text    :description
      t.integer :position,      :default => 0
    end
  end

  def self.down
    drop_table :boxes
  end
end
