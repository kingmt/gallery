require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  should_belong_to :album
end
