FactoryBot.define do
  factory :user_1, class: User do
    email                 { "nathan.lopez042@gmail.com" }
    password              { "the3ii5hoo" }
    password_confirmation { "the3ii5hoo" }
  end
end
