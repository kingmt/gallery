class PicturesController < ApplicationController
  
  before_filter :get_album
  # GET /pictures
  # GET /pictures.xml
  def index
    @pictures = @album.pictures.all 
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = @album.pictures.find(params[:id])
  end

  # GET /pictures/new
  # GET /pictures/new.xml
  def new
    @picture = @album.pictures.build
  end

  # GET /pictures/1/edit
  def edit
    @picture = @album.pictures.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.xml
  def create
    @picture = @album.pictures.build(params[:picture])

    if @picture.save
      flash[:notice] = 'Picture was successfully created.'
      redirect_to(@picture)
    else
      render :action => "new" 
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = @album.pictures.find(params[:id])
    
    if @picture.update_attributes(params[:picture])
      flash[:notice] = 'Picture was successfully updated.'
      redirect_to(@picture)
    else
      render :action => "edit" 
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    @picture = @album.pictures.find(params[:id])
    @picture.destroy

    redirect_to(album_pictures_url(@album)) 
  end
  
  private
  def get_album
    @album = Album.find(params[:album_id])
  end
end
