FactoryBot.define do
  factory :conversation_item do
    author { create :user }
  end
end
