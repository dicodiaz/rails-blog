class ResetAllUserCacheCounters < ActiveRecord::Migration[7.0]
  def up
    User.all.each do |user|
      User.reset_counters(user.id, :posts)
    end
  end

  def down
    # no rollback needed
  end
end
