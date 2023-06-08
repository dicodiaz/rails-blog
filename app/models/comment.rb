class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: :comments_counter

  # Should never be executed because there's a counter cache
  def self.update_comments_counter(post)
    post.update(comments_counter: where(post_id: post.id).count)
  end
end
