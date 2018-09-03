class Group < ApplicationRecord
    belongs_to :company
    has_many :users
    has_many :dustbin #, through: :group_dustbin_relations
end