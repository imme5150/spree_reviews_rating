Spree::Product.class_eval do
  has_many :reviews

  def stars # rounded to the nearest half
    @stars ||= (2.0 * self.avg_rating).round / 2
  end

  def recalculate_rating
    reviews_count = reviews.reload.approved.count
    if reviews_count > 0
      self.update_attributes(:avg_rating => self.reviews.approved.sum(:rating).to_f / reviews_count, :reviews_count => reviews_count)
    else
      self.update_attribute :avg_rating, 0
    end
  end
  
end
