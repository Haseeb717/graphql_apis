class User < ApplicationRecord
  rolify
	has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def valid_current_password(password)
  	self.password == password ? true : false
  end

  def send_password_reset
	  generate_token(:password_reset_token)
	  self.password_reset_sent_at = Time.zone.now
	  save!
	  UserMailer.forgot_password(self).deliver# This sends an e-mail with a link for the user to reset the password
	end
	# This generates a random password reset token for the user
	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end

	def set_authentication_token(column)
		begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	  save!
	  self[column]
	end

	def send_verification_email
		generate_token(:verification_token)
	  save!
	  UserMailer.verification_email(self).deliver#
	end

	def self.verify(token)
		User.find_by(token: token)
	end


end
