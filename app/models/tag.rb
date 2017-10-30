class Tag < ApplicationRecord
	has_many:listings, through: :listing_tags
end
