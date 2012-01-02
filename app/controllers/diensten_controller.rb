class DienstenController < ApplicationController
	manageable_content_for :grondwerk, :bestraten, :tuinaanleg, :slopen, :korte_samenvatting

  def grondwerk
		@pictures = Picture.where(:category => "grondwerk").order("position")
  end

  def bestraten
		@pictures = Picture.where(:category => "bestraten").order("position")
  end

  def tuinaanleg
		@pictures = Picture.where(:category => "tuinaanleg").order("position")
  end

  def slopen
		@pictures = Picture.where(:category => "slopen").order("position")
  end
end
