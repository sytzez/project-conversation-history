class Comment < ApplicationRecord
  has_one :conversation_item, as: :item

  delegate :created_at, :author, to: :conversation_item

  validates :content, presence: true
end
