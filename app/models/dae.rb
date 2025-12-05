class Dae < ApplicationRecord
  reverse_geocoded_by :lat, :long
end
