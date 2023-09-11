# This will guess the User class
require 'date'
require 'faker'
FactoryBot.define do

  factory :admin, class: "User" do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name  }
    email { "#{first_name}@musicon.com" }
    password { "123456" }
    date_of_birth { Date.new }
    phone_number { "07397282826" }
    is_admin { true }
  end

  factory :guest, class: "User" do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name  }
    email { "#{first_name}@musicon.com" }
    password { "123456" }
    date_of_birth { Date.new }
    phone_number { "07397282826" }
    is_admin { true }
  end



  factory :lesson do
    name { Faker::ProgrammingLanguage.name  }
    description { "Intro lesson" }
    price { 55.00 }
    duration { 60 }
    association :user, factory: :admin
  end

  factory :lesson_order do
    discount { 20 }
    package { 10 }
    association :user, factory: :guest
    association :lesson, factory: :lesson
  end

  factory :booking do
    booking_date { '2023-10-21' }
    status { "pending" }
    association :lesson_order
  end

  factory :slot do
    start_time { '08:00:00' }
    end_time { '09:00:00' }
    is_available { true }
    association :lesson
  end


  # Invalid factory builds
  factory :invalid_lesson, class: Lesson do
    name { nil }
    price { 521 }
    duration { 1000 }
    # other attributes that make it invalid
  end

  factory :lesson_no_admin, class: Lesson do
    name { Faker::ProgrammingLanguage.name  }
    description { "Intro lesson" }
    price { 55.00 }
    duration { 60 }
  end
end
