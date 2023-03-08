class ConversationItem < ApplicationRecord
  # Associations
  belongs_to :author, class_name: 'User'
  belongs_to :item, polymorphic: true, optional: false

  # Scopes
  scope :latest_first, -> { order(created_at: :desc) }
end
