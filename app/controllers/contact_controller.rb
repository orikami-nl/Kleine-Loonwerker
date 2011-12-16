class ContactController < ApplicationController
  def index
  end

  def send_contact
		redirect_to root_path, :notice => "Uw bericht is verzonden, u hoort snel iets van ons terug."
  end

end
