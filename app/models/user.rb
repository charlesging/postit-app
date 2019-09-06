
class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  # add our own validations
  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true

  # password not a column in db, but a virtual attribute of User
  # password validation will only fire upon creation of a NEW user object
  # withoput "on: :create", will expect password even on update
  validates :password, presence: true, on: :create, length: {minimum: 5}
end