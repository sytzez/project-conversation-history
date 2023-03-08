FactoryBot.define do
  factory :conversation_item do
    transient do
      with_item { nil }
    end

    author { create :user }

    item { with_item }

    trait :status_update do
      item { create :status_update, :planned }
    end

    trait :comment do
      item { create :comment }
    end
  end
end
