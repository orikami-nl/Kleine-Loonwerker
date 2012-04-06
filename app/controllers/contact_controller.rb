class ContactController < ApplicationController
	#before_filter :check_honeypots, :only => [:send_contact]
	manageable_content_for :contact, :korte_samenvatting

  def check_honeypots
    return true if honeypot_untouched?
    flash[:notice] = 'U bent een spambot, of gebruikt een vreemd script. (Zo niet, dan heb ik overdreven gereageerd. Probeer het alstublieft nog eens.)'
    redirect_to :controller => "contact", :action => "index", :contact_mail => params[:contact_mail]
    return false
  end

  def honeypot_untouched?
    submitted = params['its_so_sweet']
    return false if submitted.blank?
    submitted['email'] == 'john@doe.com' && submitted['name'] == '' && submitted['agree'].blank?
	end

  def index
    @contact_mail = ContactMail.new(params[:contact_mail])
		@review = Review.new
  end

  def send_contact
    @contact_mail = ContactMail.new(params[:contact_mail])
		if @contact_mail.deliver
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "Uw bericht is verzonden, u hoort snel iets van ons terug."
}
        format.js {render}
			end
    else
      render :action => :index
    end
  end

end
