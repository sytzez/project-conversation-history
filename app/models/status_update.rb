class StatusUpdate < ApplicationRecord
  # Enums
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

  # Associations
  has_one :conversation_item, as: :item

  # Delegations
  delegate :created_at, :author, to: :conversation_item

  # Validations
  validates :status, presence: true

  validate :validate_status_has_changed, on: :create

  # Scopes
  scope :with_conversation_items, -> { includes(:conversation_item).order('conversation_items.created_at': :desc) }

  # The current status of the project. Can be nil.
  def self.current
    StatusUpdate.with_conversation_items.first
  end

  # The status update just before this one. Can be nil.
  def previous_status_update
    self.class
        .with_conversation_items
        .where('conversation_items.created_at < ?', conversation_item.created_at)
        .first
  end

  # The status just before this one. Can be nil.
  def previous_status
    previous_status_update&.status
  end

  # Validates that the status of the project is changed by this update.
  def validate_status_has_changed
    latest_status_update = self.class.current

    return unless latest_status_update.present?

    if status == latest_status_update.status
      errors.add(:status, 'The project already has this status')
    end
  end
end
