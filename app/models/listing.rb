class Listing < ApplicationRecord
	
	def self.search(search)
  		where("city LIKE ?", "%#{search}%") 
  		where("country LIKE ?", "%#{search}%")
  		where("address LIKE ?", "%#{search}%")
	end
end
