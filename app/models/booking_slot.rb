class BookingSlot < ApplicationRecord
  belongs_to :booking
  belongs_to :slot
end
