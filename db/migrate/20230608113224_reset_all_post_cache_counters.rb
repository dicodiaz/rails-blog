class ResetAllPostCacheCounters < ActiveRecord::Migration[7.0]
  def up
    Post.all.each do |post|
      Post.reset_counters(post.id, :comments, :likes)
    end
  end

  def down
    # no rollback needed
  end
end
