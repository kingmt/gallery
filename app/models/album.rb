class Album < ActiveRecord::Base
  belongs_to :user
  has_many :pictures
end
