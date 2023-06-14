class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: :posts_counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { in: 1..250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  # Should never be executed because there's a counter cache
  def self.update_posts_counter(user)
    user.update(posts_counter: where(author_id: user.id).count)
  end

  def five_most_recent_comments
    Comment.where(post_id: id).order(updated_at: :desc).limit(5).sort_by(&:updated_at)
  end
end
