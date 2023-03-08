class StatusUpdate < ApplicationRecord
  enum status: {
    proposed: 0,
    planned: 1,
    cancelled: 2,
    early_development: 3,
    on_hold: 4,
    alpha: 5,
    beta: 6,
    live: 7,
    deprecated: 8,
    end_of_life: 9,
  }

  has_one :conversation_item, as: :item

  delegate :created_at, :author, to: :conversation_item

  validates :status, presence: true
end
