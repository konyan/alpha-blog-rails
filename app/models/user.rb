class User < ActiveRecord::Base
  validates :username, presence: true,
            uniqueness:true,
            length: {minimum: 3, maximum: 30}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence:true,
            uniqueness: true,
            format: {with: VALID_EMAIL_REGEX}
end