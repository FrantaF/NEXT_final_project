class City < ApplicationRecord
    belongs_to :state
    has_many :areas
    has_many :dustbins
end