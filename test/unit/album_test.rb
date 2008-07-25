require 'test_helper'

class AlbumTest < ActiveSupport::TestCase

  should_belong_to :user
  should_have_many :pictures
  
end
