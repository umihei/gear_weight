class Gear < ApplicationRecord
    belongs_to :mntevents, class_name: 'Mntevent'
    belongs_to :user
    
    validates :name, presence: true
    validates :weight, presence: true, numericality: { only_integer: true }
end
