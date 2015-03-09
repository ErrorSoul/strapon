# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  asset      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Photo < ActiveRecord::Base
  mount_uploader :asset, AssetUploader		  
end
