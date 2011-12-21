class Review < ActiveRecord::Base
	attr_accessible :name, :comment, :city, :show_on_frontpage, :rating
	validates_numericality_of :rating, :only_integer => true
	validates_inclusion_of :rating, :in => 1..5
	validate :no_more_than_three_reviews_on_frontpage

  after_initialize :default_values

	def no_more_than_three_reviews_on_frontpage
		shown_reviews = Review.where(:show_on_frontpage => true)
		if self.show_on_frontpage == true && shown_reviews.count >= 3
	     errors.add(:show_on_frontpage, "Je kunt niet meer dat drie referenties op de voorpagina zetten")
		end
	end

  private

  def default_values
    self.show_on_frontpage ||= false
  end

end
