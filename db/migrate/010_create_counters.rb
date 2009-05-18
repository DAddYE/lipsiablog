class CreateCounters < ActiveRecord::Migration
  def self.up
    add_column :posts,      :comments_count, :integer, :default => 0
    add_column :categories, :posts_count,    :integer, :default => 0
    
    Post.reset_column_information
    Post.all.each do |p|
      Post.update_counters p.id, :comments_count => p.comments.length
    end
    
    Category.reset_column_information
    Category.all.each do |c|
      Category.update_counters c.id, :posts_count => c.posts.length
    end
  end

  def self.down
    remove_column :posts,      :comments_count
    remove_column :categories, :posts_count
  end
end
