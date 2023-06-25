class Mntevent < ApplicationRecord
    # has_many :gears
    has_many :gears, foreign_key: :mntevents_id
end
