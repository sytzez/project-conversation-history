class ConversationItem < ApplicationRecord
  default_scope { order(created_at: 'desc') }

  belongs_to :author, class_name: 'User'
  belongs_to :item, polymorphic: true, optional: false
end
