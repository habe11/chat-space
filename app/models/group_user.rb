class GroupUser < ApplicationRecord
  belongs_to :group
  # belongs_toは1対1を表すメソッド
  belongs_to :user
end
