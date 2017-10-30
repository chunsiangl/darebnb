class User < ApplicationRecord
  include Clearance::User
  has_many :listings
  has_many :authentications, dependent: :destroy
  enum role: [:customer, :moderator, :superadmin]
  def self.create_with_auth_and_hash(authentication, auth_hash)

  	user = self.create!(
  		first_name: auth_hash["extra"]["raw_info"]["first_name"],
      last_name: auth_hash["extra"]["raw_info"]["last_name"],
  		email: auth_hash["extra"]["raw_info"]["email"],
      password: SecureRandom.hex(3)
  		)
  	user.authentications << authentication
  	return user

  end


  def fb_token
  	x = self.authentications.find_by(provider: 'facebook')
  	return x.token unless x.nil?
  end

end
