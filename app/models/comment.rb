class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  alias_attribute :author , :user
end
