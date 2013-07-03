require 'bcrypt'

class User < ActiveRecord::Base
  validates :name, :email, :password, presence: true
  validates :email, :format => { :with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/, :message => "Invalid Email" }
  validates :email, uniqueness: { message: "Email already in use"}

  include BCrypt


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password 
  end

end


#   def encrypt_password
#     self.password = Digest::SHA1.hexdigest(self.password)
#   end

#   def self.authenticate(email, password)
#     User.where(email: email, password: Digest::SHA1.hexdigest(password)).first
#   end

# end
