class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  validates :title, presence: true
  validates :description, presence: true
end
