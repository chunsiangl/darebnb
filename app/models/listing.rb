class Listing < ApplicationRecord
	include Filterable

	belongs_to :user 
	has_many :tags, through: :listing_tags
  

  # scope :city, -> (city) { where city: city }
  # scope :country, -> (location_id) { where location_id: country
  # scope :starts_with, -> (title) { where("title like ?", "#{title}%")}

	def self.search(search)
  		where("city ILIKE ? OR country ILIKE ? OR address ILIKE ? OR title ILIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%" ) 
	end


end
