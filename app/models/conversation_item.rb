class ConversationItem < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :item, polymorphic: true
end
