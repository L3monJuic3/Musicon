# This will guess the User class
require 'date'
FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    is_admin { false }
    email {"test@musicon.com"}
    password {"123456"}
    phone_number {"07397282826"}
    date_of_birth {Date.new}

    factory :lesson do
      name { "lesson 2" }
      description { "intro_lesson" }
      price { 55.00 }
      duration { 60 }
    end

    factory :lesson_order do
      discount { 20 }
      package { 10 }
    end
  end

  # Building lessons factory


end
