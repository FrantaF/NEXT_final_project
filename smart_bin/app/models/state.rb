class State < ApplicationRecord
    has_many :cities
    has_many :areas
    has_many :dustbins
end