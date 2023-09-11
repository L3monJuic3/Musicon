class Slot < ApplicationRecord
  belongs_to :lesson

  has_many :booking_slots, dependent: :destroy
  has_many :bookings, through: :booking_slots

  # validates :start_time, presence: true
  validates :end_time, presence: true
  validates :start_time, presence: true, uniqueness: { scope: :lesson_id, message: "slot start-time must be unique" }

end
