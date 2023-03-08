class StatusUpdate < ApplicationRecord
  default_scope { includes(:conversation_item) }

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

  # The status update just before this one. Can be nil.
  def previous_status_update
    self.class
        .where('conversation_items.created_at < ?', conversation_item.created_at)
        .order('conversation_items.created_at': :desc)
        .first
  end

  # The status just before this one. Can be nil.
  def previous_status
    previous_status_update&.status
  end
end
