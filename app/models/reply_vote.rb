class ReplyVote < ActiveRecord::Base
  has_one :user
  has_one :reply
end
