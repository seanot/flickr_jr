class Photo < ActiveRecord::Base 
  belongs_to :album

  has_one :user, through: :album
  
  mount_uploader :file, Uploader
end