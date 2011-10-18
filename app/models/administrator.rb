class Administrator < ActiveRecord::Base

  belongs_to :user

  validates :user, :uniqueness => true
  validates :user, :presence => true
end
