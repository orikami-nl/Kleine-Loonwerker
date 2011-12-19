class PicturesController < ApplicationController
	before_filter :authenticate_admin! 

  # GET /pictures
  # GET /pictures.json
  def index
    @grondwerk_pictures = Picture.where(:category => "grondwerk").order("position")
		@bestraten_pictures = Picture.where(:category => "bestraten").order("position")
		@tuinaanleg_pictures = Picture.where(:category => "tuinaanleg").order("position")
		@slopen_pictures = Picture.where(:category => "slopen").order("position")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @picture = Picture.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(params[:picture])

    if @picture.save
      redirect_to pictures_path, notice: 'Foto is succesvol toegevoegd'
    else
      render action: "new"
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update
    @picture = Picture.find(params[:id])

    if @picture.update_attributes(params[:picture])
      redirect_to pictures_path, notice: 'Foto is succesvol bewerkt'
    else
      render action: "edit"
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url }
      format.json { head :ok }
    end
  end
end
