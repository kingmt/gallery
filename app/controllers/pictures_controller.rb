class PicturesController < ApplicationController
  
  before_filter :logged_in?, :owner?, :except => [:index]
  before_filter :get_album, :only => [:index]
  # GET /pictures
  # GET /pictures.xml
  def index
    @pictures = @album.pictures.all 
    @picture = @album.pictures.build
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = @album.pictures.find(params[:id])
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
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to(album_pictures_path(@album))
    else
      @pictures = @album.pictures.all 
      render :action => "index" 
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = @album.pictures.find(params[:id])
    
    if @picture.update_attributes(params[:picture])
      flash[:notice] = 'Picture was successfully updated.'
      redirect_to(album_pictures_path(@album))
    else
      render :action => "edit" 
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    @picture = @album.pictures.find(params[:id])
    @picture.destroy
    flash[:notice] = 'Picture was successfully removed.'
    redirect_to(album_pictures_path(@album)) 
  end
  
  private
  def get_album
    @album = Album.find(params[:album_id])
  end
  
  def owner?
    get_album
    logged_in? && 
      current_user && 
      current_user.id == @album.user.id
  end
end
