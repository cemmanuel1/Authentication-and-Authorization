require 'Digest'

class User < ActiveRecord::Base
  validates :name, :email, :password_hash, presence: true
  validates :email, :format => { :with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/, :message => "Invalid Email" }
  validates :email, uniqueness: { message: "Email already in use"}

  before_save :encrypt_password

  def encrypt_password
    self.password_hash = Digest::SHA1.hexdigest(self.password)
  end

  def self.authenticate(email, password)
    User.where(email: email, password_hash: Digest::SHA1.hexdigest(password)).first
  end

end