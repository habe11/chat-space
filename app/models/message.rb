class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :content, presence: true, unless: :image?
  # unless: :image? = もし、imageカラムが空だったら制御
  mount_uploader :image, ImageUploader
  # 
end
