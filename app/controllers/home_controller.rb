class HomeController < ApplicationController
	manageable_content_for :inleiding, :slopen_kort, :verhuur_kort, :titel_zin

  def index
  end

end
