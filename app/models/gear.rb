class Gear < ApplicationRecord
    belongs_to :mntevents, class_name: 'Mntevent'
    belongs_to :user
end
