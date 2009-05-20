class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :post
      t.string     :name
      t.string     :email
      t.string     :website
      t.text       :description
      t.string     :ip
      t.boolean    :spam, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
