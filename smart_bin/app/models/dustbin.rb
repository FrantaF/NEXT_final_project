class Dustbin < ApplicationRecord
    belongs_to :area
    belongs_to :city
    belongs_to :state
    belongs_to :group #, through: :group_dustbin_relations
    has_one :raspberrypi
end
