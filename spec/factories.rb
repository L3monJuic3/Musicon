# This will guess the User class
require 'date'

FactoryBot.define do

  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    email { "ethan5@musicon.com" }
    password { "123456" }
    date_of_birth { Date.new }

    trait :admin do
      is_admin { true }
    end

    trait :phone_number do
      phone_number { "07397282826" }
    end
  end

  factory :lesson do
    name { "Lesson 2" }
    description { "Intro lesson" }
    price { 55.00 }
    duration { 60 }
    association :user, factory: :user
  end

  factory :lesson_order do
    discount { 20 }
    package { 10 }
    association :user, factory: :user
    association :lesson, factory: :lesson
  end

  factory :booking do
    booking_date { '2023-10-21' }
    status { "pending" }
    association :lesson_order, factory: :lesson_order
  end

  factory :slot do
    start_time { '08:00:00' }
    end_time { '09:00:00' }
    is_available { true }
    association :lesson, factory: :lesson
  end
end
