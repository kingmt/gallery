class Picture < ActiveRecord::Base
  belongs_to :album
  
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :resize_to => '640x400',
                 :max_size => 1.megabyte,
                 :thumbnails => {:thumb => '100x100', :geometry => 'x50'}
    
  validates_presence_of :filename
  #validates_as_attachment

end
