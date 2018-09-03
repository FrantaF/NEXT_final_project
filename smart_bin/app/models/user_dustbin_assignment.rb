class UserDustbinAssignment < ApplicationRecord
    belongs_to :user
    belongs_to :dustbin
end
