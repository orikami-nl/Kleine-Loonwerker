class ReviewsController < ApplicationController
	before_filter :check_honeypots, :only => [:create]
	before_filter :authenticate_admin!, :only => [:index, :update, :destroy]

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

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(params[:review])

    if @review.save
      redirect_to contact_path, :notice => "Uw waardering is geplaatst, hartelijk dank!"
    else
			redirect_to contact_path, :notice => "Uw waardering kan op dit moment niet geplaatst worden, probeer het later nog eens."
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])

    if @review.update_attributes(params[:review])
			redirect_to reviews_path, :notice => "De waardering is aangepast."
    else
			redirect_to reviews_path, :notice => "De aanpassing kan op dit moment niet worden doorgevoerd. Het is mogelijk dat je meer dan drie referenties wilt aanvinken voor op de voorpagina."
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :ok }
    end
  end
end
