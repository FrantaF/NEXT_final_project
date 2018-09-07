class Dustbin < ApplicationRecord
    #Geographical Info
    belongs_to :area
    belongs_to :city
    belongs_to :state
    belongs_to :fill_level
    #User to Dustbin Assignments
    has_many :user_dustbin_assignments
    has_many :users, through: :user_dustbin_assignments
    #User to Dustbin Assignments
    has_many :dustbin_stats
    #Raspberry Pi Connection
    has_one :raspberrypi

end
