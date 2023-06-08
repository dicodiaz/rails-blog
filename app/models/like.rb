class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: :likes_counter

  # Should never be executed because there's a counter cache
  def self.update_likes_counter(post)
    post.update(likes_counter: where(post_id: post.id).count)
  end
end
