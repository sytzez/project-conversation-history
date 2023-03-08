class Comment < ApplicationRecord
  default_scope { includes(:conversation_item).order('conversation_items.created_at': :desc) }

  has_one :conversation_item, as: :item

  delegate :created_at, :author, to: :conversation_item

  validates :content, presence: true
end
