class Booking < ApplicationRecord
  belongs_to :slot
  belongs_to :user
end
