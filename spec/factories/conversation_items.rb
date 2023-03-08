FactoryBot.define do
  factory :conversation_item do
    author { create :user }

    trait :status_update do
      item { create :status_update, :planned }
    end

    trait :comment do
      item { create :comment }
    end
  end
end
