require 'bcrypt'

class User < ActiveRecord::Base
  validates :first_name, :email, :password_hash, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}/,
                              message: "must be a valid email" }



  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
