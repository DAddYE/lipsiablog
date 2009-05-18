class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.references :account
      t.string     :name
      t.text       :description_short
      t.text       :description_long
      t.string     :tags
      t.integer    :menu,        :default => 0
      t.integer    :position,    :default => 0
      t.boolean    :commentable, :default => true
      t.boolean    :draft,       :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
