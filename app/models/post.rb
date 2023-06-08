class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: :posts_counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Should never be executed because there's a counter cache
  def self.update_posts_counter(user)
    user.update(posts_counter: where(author_id: user.id).count)
  end

  def five_most_recent_comments
    Comment.where(post_id: id).order(updated_at: :desc).limit(5)
  end
end
