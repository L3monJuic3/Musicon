# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'date'

puts "Cleaning up database..."

# Booking.destroy_all

Slot.destroy_all
LessonOrder.destroy_all
Lesson.destroy_all
User.destroy_all

puts "Database cleaned"

user_one = User.create!(
  email: "visitor@musicon.com",
  first_name: "ethan",
  last_name: "lane",
  password: "123456789",
  phone_number: "07397282826",
  is_admin: true,
  date_of_birth: Date.new
)
user_one.save

user_two = User.create(
  email: "visitor@lewagon.com",
  first_name: "Peter",
  last_name: "lane",
  password: "123456789",
  phone_number: "07397282826",
  is_admin: true
)

lesson = Lesson.create(
  name: 'Lesson 1',
  description: 'Perfect to get to know the teacher and try it out at low cost',
  duration: 60,
  price: 15,
  user_id: user_one.id
)
i = 10
until i == 23
  slot1 = Slot.create(lesson_id: lesson.id, start_time: Time.new(2022, 12, 2, i, 0, 0), end_time: DateTime.new(2022, 12, 2, (i+1), 0, 0) )
  i += 1
end


lesson = Lesson.create!(
  name: 'Lesson 55',
  description: 'Perfect to get to know the teacher and try it out at low cost',
  duration: 90,
  price: 20,
  price_cents: (lesson.price * 100).to_i,
  user_id: user_one.id
)



LessonOrder.create!(
user_id: user_one.id,
lesson_id: lesson.id,
discount: 20,
package: 1
)


LessonOrder.create!(
  user_id: user_one.id,
  lesson_id: lesson.id,
  discount: 20,
  package: 5
)


LessonOrder.create!(
  user_id: user_one.id,
  lesson_id: lesson.id,
  discount: 20,
  package: 10
)

LessonOrder.create!(
  user_id: user_one.id,
  lesson_id: lesson.id,
  discount: 20,
  package: 20
)

LessonOrder.create!(
  user_id: user_one.id,
  lesson_id: lesson.id,
  discount: 20,
  package: 40
)
