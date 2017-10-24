class RemoveReviewAndRatingFromListing < ActiveRecord::Migration[5.1]
  def change
    remove_column :listings, :review, :string
    remove_column :listings, :rating, :integer
  end
end
