class Area < ApplicationRecord
    belongs_to :city
    belongs_to :state
    has_many :dustbins
end