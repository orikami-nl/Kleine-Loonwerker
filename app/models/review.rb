class Review < ActiveRecord::Base
	attr_accessible :name, :comment, :city, :show_on_frontpage, :rating
	validates_numericality_of :rating, :only_integer => true
	validates_inclusion_of :rating, :in => 1..5

	before_save :check_show_on_frontpage
  after_initialize :default_values

	def check_show_on_frontpage
		shown_reviews = Review.where(:show_on_frontpage => true)
		if shown_reviews.count > 3
			self.show_on_frontpage = false
		end
	end

  private

  def default_values
    self.show_on_frontpage ||= false
  end

end
