class Dustbin < ApplicationRecord
    #Geographical Info
    belongs_to :area
    belongs_to :city
    belongs_to :state
    #User to Dustbin Assignments
    has_many :user_dustbin_assignments
    has_many :users, through: :user_dustbin_assignments
    #Raspberry Pi Connection
    has_one :raspberrypi
end
