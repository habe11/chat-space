class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  validates :name, presence: true, uniqueness: true
  # valdates(制限)、存在しなければならない、唯一でなけばならない
end
