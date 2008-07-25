require File.dirname(__FILE__) + '/../test_helper'

class PicturesControllerTest < ActionController::TestCase
  
  def setup
    @album = Album.first
    @picture = @album.pictures.first
  end
  
  context 'logged in' do
    setup {login_as(:quentin)}
    
    should_be_restful do |resource|
      resource.parent  = [:album]
      resource.formats = [:html]
      resource.create.flash  = /uploaded/i
      resource.create.redirect  = "album_pictures_path(@album)"
      resource.update.redirect  = "album_pictures_path(@album)"
    end
    
    should 'zzz debug' do

    end
    
  end
  
  
  

end
