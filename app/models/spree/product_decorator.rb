Spree::Product.class_eval do
  has_many :reviews

  def stars # rounded to the nearest half
    @stars ||= (2.0 * self.avg_rating).round / 2.0
  end

  def recalculate_rating
    reviews_count = reviews.reload.approved.where('rating is not null').count
    if reviews_count > 0
      avg_rating =  self.reviews.approved.sum(:rating).to_f / reviews_count
    else
      # if there are no approved reviews w/ ratings, use all approved reviews
      reviews_count = reviews.approved.count
      avg_rating = 0
    end
    self.update_attributes({avg_rating:avg_rating, reviews_count:reviews_count}, :without_protection => true)
  end
  
end
