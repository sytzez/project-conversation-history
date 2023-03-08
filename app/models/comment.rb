class Comment < ApplicationRecord
  # Associations
  has_one :conversation_item, as: :item

  # Delegations
  delegate :created_at, :author, to: :conversation_item

  # Validations
  validates :content, presence: true

  # Scopes
  scope :with_conversation_items, -> { includes(:conversation_item).order('conversation_items.created_at': :desc) }
end
