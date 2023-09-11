class Booking < ApplicationRecord
  belongs_to :slot
  belongs_to :user

  has_many :booking_slots, dependent: :destroy
  has_many :slots, through: :booking_slots

  validates :booking_date, presence: true
  validates :status, presence: true

end
