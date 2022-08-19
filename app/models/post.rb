class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments
  alias_attribute :author , :user
end
