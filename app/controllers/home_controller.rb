class HomeController < ApplicationController
	manageable_content_for :inleiding, :slopen_kort, :verhuur_kort, :titel_zin

  def index
		@reviews = Review.where(:show_on_frontpage => true).first(3)
  end

end
