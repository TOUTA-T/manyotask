FactoryBot.define do
  factory :user do
    # これでメールのバリデーションを解消していた
    # sequence(:name) { |n|"sample#{n}" }
    # sequence(:email) { |n|"sample#{n}@aol.com" }
    name { "sample1" }
    email { "sample1@aol.com" }
    password { "password" }
    admin { "true" }
  end
  factory :user2, class: User do
    name { "sample2" }
    email { "sample2@aol.com" }
    password { "password" }
    admin { "false" }
  end
end
