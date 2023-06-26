class Mntevent < ApplicationRecord
    # has_many :gears
    has_many :gears, foreign_key: :mntevents_id
    belongs_to :user
    
    validates :eventname, presence: true
    validates :eventdate, presence: true
    validates :mnt, presence: true
end
