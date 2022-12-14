class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts
  has_many :comments
  has_many :likes

  validates :name, presence: true
  validates :postscounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def most_recent_post
    Post.where(user: self).order(created_at: :desc).limit(3)
  end


  def authenticate(pwd)
    password == pwd
  end
  def is?(requested_role)
    self.role = requested_role.to_s

  end
end
