FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password_digest { "mamakane" }
    admin { false }

    factory :admin do
      admin { true }
    end
  end
end
