class AlbumsController < ApplicationController
  
  before_filter :logged_in?, :except => [:index]
  before_filter :owner?, :except => [:index, :new, :create]
  # GET /albums
  # GET /albums.xml
  def index
    if logged_in? && params[:all] == 'false'
      @albums = current_user.albums.all
      session[:all] = false
    else
      @albums = Album.find(:all)
      session[:all] = true
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = current_user.albums.build(params[:album])
    if @album.save
      flash[:notice] = 'Album was successfully created.'
      redirect_to(album_pictures_path(@album))
    else
      render :action => "new"
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    if @album.update_attributes(params[:album])
      flash[:notice] = 'Album was successfully updated.'
    else
      flash[:error] = @album.errors.full_messages.join(' ')
    end
    redirect_to album_pictures_path(@album)

  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album.destroy
    flash[:notice] = 'Album was successfully removed.'
    redirect_to(albums_url)
  end
  
  private
  def owner?
    @album = Album.find(params[:id])
    logged_in? && current_user && current_user.id == @album.user.id
  end
end
