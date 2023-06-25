class Gear < ApplicationRecord
    belongs_to :mntevents, class_name: 'Mntevent'
end
